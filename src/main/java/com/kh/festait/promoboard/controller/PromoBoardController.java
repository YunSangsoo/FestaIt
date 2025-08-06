package com.kh.festait.promoboard.controller;

import java.util.*;
import java.io.File;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import javax.servlet.ServletContext; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.ResponseEntity;

import com.kh.festait.common.Utils;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.Pagination;
import com.kh.festait.promoboard.model.service.PromoBoardService;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;
import com.kh.festait.security.model.vo.UserExt;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.service.ImageService; 

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/promoBoard")
@Slf4j
@MultipartConfig
public class PromoBoardController {

    private final PromoBoardService promoService;

    @Autowired 
    private final ImageService imgService;
    @Autowired 
    private ServletContext application; 

    /*
     * 홍보 게시판의 BoardCode는 P (Promotion)
     * 이미지는 모두 한 테이블에 저장되기 때문에,
     * 어느 페이지에서 사용된 이미지인지 분류하기 위해 사용
     */
    private String boardCode = "P";

    // 홍보 게시글 목록 및 검색
    @GetMapping
    public String selectPromotionList(
        @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
        @RequestParam Map<String, Object> paramMap,
        Model model
    ) {
        String searchKeyword = (String) paramMap.get("searchKeyword");

        PageInfo pi;
        List<PromoBoardVo> list;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            int listCount = promoService.selectSearchPromoCount(searchKeyword);
            pi = Pagination.getPageInfo(listCount, currentPage, 12, 12);
            list = promoService.selectSearchPromo(searchKeyword, pi);
        } else {
            int listCount = promoService.selectPromoCount();
            pi = Pagination.getPageInfo(listCount, currentPage, 12, 12);;
            list = promoService.selectPromoList(pi);
        }

        model.addAttribute("promoList", list);
        model.addAttribute("pi", pi);
        model.addAttribute("param", paramMap);
        return "promotion/promoBoard";
    }

    // 홍보 게시글 상세 조회
    @GetMapping("/detail")
    public String selectPromoDetail(
        @RequestParam("promoId") int promoId,
        Model model,
        RedirectAttributes ra,
        @CookieValue(value = "readPromoId", required = false) String readCookie,
        HttpServletRequest req,
        HttpServletResponse res,
        Authentication authentication
    ) {
        UserExt loginUser = getLoginUser(authentication);

        PromoBoardVo promo = null;

        boolean isAdmin = false;
        if (loginUser != null) {
            isAdmin = loginUser.getAuthorities().stream()
                              .anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuthority()));
        }

        if (isAdmin) {
            // 관리자면 비활성 상태 포함 상세 조회
            promo = promoService.selectPromoDetailIncludingInactive(promoId);
        } else {
            // 일반사용자면 활성 상태 게시글만 조회
            promo = promoService.selectPromoDetail(promoId);
        }

        if (promo == null) {
            ra.addFlashAttribute("alertMsg", "해당 게시물을 찾을 수 없거나 접근 권한이 없습니다.");
            return "redirect:/promoBoard";
        }

        Image posterImage = imgService.getImageByRefNoAndType(promoId, boardCode);
        promo.setPosterImage(posterImage);

        if (loginUser != null) {
            model.addAttribute("loginUser", loginUser);
        }

        int userNo = (loginUser != null) ? loginUser.getUserNo() : 0;

        // 조회수 증가 로직
        if (userNo != 0 && userNo != promo.getWriterUserNo()) {
            boolean increase = false;

            if (readCookie == null) {
                increase = true;
                readCookie = String.valueOf(promoId);
            } else {
                List<String> readIds = Arrays.asList(readCookie.split("/"));
                if (!readIds.contains(String.valueOf(promoId))) {
                    increase = true;
                    readCookie += "/" + promoId;
                }
            }

            if (increase && promoService.increasePromoViews(promoId) > 0) {
                promo.setViews(promo.getViews() + 1);
                Cookie newCookie = new Cookie("readPromoId", readCookie);
                newCookie.setPath(req.getContextPath());
                newCookie.setMaxAge(3600);
                res.addCookie(newCookie);
            }
        }

        model.addAttribute("promo", promo);
        return "promotion/promoDetail";
    }

    // 홍보 게시글 작성 페이지
    @GetMapping("/promoWrite")
    public String promoWriteForm(Model model, RedirectAttributes ra, Authentication authentication) {
        UserExt loginUser = getLoginUser(authentication);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 게시글을 작성할 수 있습니다.");
            return "redirect:/user/login";
        }

        int userNo = loginUser.getUserNo();

        List<PromoBoardVo> eventApps = promoService.selectUserEventApplications(userNo);
        model.addAttribute("eventApplications", eventApps);
        if (eventApps.isEmpty()) {
            model.addAttribute("infoMsg", "등록된 행사가 없습니다.");
        }

        if (!model.containsAttribute("promo")) {
            model.addAttribute("promo", new PromoBoardVo());
        }

        return "promotion/promoWrite";
    }

    // 홍보 게시글 작성 처리
    @PostMapping("/promoWrite")
    public String insertPromo(
        @ModelAttribute PromoBoardVo promo,
        @RequestParam(value = "promoPoster", required = false) MultipartFile file,
        RedirectAttributes ra,
        Authentication authentication
    ) {
        UserExt loginUser = getLoginUser(authentication);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 정보가 없습니다. 다시 로그인해주세요.");
            return "redirect:/user/login";
        }
        promo.setWriterUserNo(loginUser.getUserNo());

        try {
            sanitizePromoFields(promo);
            
            // 이미지 처리 로직
            Image posterImage = null; 
            if (file != null && !file.isEmpty()) {
                String newChangeName = Utils.saveFile(file, application, boardCode); 
                if (newChangeName == null) {
                    ra.addFlashAttribute("alertMsg", "파일 업로드 실패.");
                    return "redirect:/common/errorPage";
                }
                posterImage = new Image();
                posterImage.setImgType(boardCode);
                posterImage.setOriginName(file.getOriginalFilename());
                posterImage.setChangeName(newChangeName);
                posterImage.setImgOrder(1); 
            }
            
            int result = promoService.insertPromo(promo, posterImage);

            if (result > 0) {
                ra.addFlashAttribute("alertMsg", "홍보 게시글이 작성되었습니다.");
                return "redirect:/promoBoard";
            }

            ra.addFlashAttribute("alertMsg", "작성에 실패했습니다.");
            ra.addFlashAttribute("promo", promo); 
            return "redirect:/promoBoard/promoWrite";

        } catch (RuntimeException e) {
            log.error("게시글 등록 중 오류", e);
            ra.addFlashAttribute("errorMsg", getExceptionMessage(e));
            return "common/errorPage";
        }
    }

    // 수정 페이지 요청
    @GetMapping("/promoUpdate")
    public String promoUpdateForm(
        @RequestParam("promoId") int promoId,
        Model model,
        RedirectAttributes ra,
        Authentication authentication
    ) {
        UserExt loginUser = getLoginUser(authentication);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/user/login";
        }

        PromoBoardVo promo = promoService.selectPromoDetail(promoId);
        if (promo == null) {
            ra.addFlashAttribute("alertMsg", "게시글이 존재하지 않습니다.");
            return "redirect:/promoBoard";
        }

        boolean isAdmin = loginUser.getAuthorities().stream()
                                   .anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuthority()));

        if (loginUser.getUserNo() != promo.getWriterUserNo() && !isAdmin) {
            ra.addFlashAttribute("alertMsg", "수정 권한이 없습니다.");
            return "redirect:/promoBoard/detail?promoId=" + promoId;
        }

        // 이미지 조회
        Image posterImage = imgService.getImageByRefNoAndType(promoId, boardCode);
        promo.setPosterImage(posterImage); 

        if (!model.containsAttribute("promo")) {
            model.addAttribute("promo", promo);
        }

        List<PromoBoardVo> apps = promoService.selectUserEventApplications(loginUser.getUserNo());
        model.addAttribute("eventApplications", apps);
        if (apps.isEmpty()) {
            model.addAttribute("infoMsg", "작성 가능한 행사가 없습니다.");
        }

        return "promotion/promoUpdate";
    }

    // 수정 처리
    @PostMapping("/promoUpdate")
    public String updatePromo(
        @ModelAttribute PromoBoardVo promo,
        @RequestParam(value = "promoPoster", required = false) MultipartFile file,
        @RequestParam(value="existingImgNo", required=false, defaultValue="0") int existingImgNo,
        RedirectAttributes ra,
        Authentication authentication
    ) {
        UserExt loginUser = getLoginUser(authentication);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/user/login";
        }

        try {
            sanitizePromoFields(promo);
            
            // 이미지 처리 로직
            Image posterImage = null; 
            String oldChangeName = promo.getPosterImage() != null ? promo.getPosterImage().getChangeName() : null;

            // 1. 새로운 파일이 업로드된 경우
            if (file != null && !file.isEmpty()) {
                if (oldChangeName != null && !oldChangeName.isEmpty()) {
                    deleteFileFromServer(oldChangeName, application);
                }

                // 새 파일 업로드
                String newChangeName = Utils.saveFile(file, application, boardCode);
                if (newChangeName == null) {
                    ra.addFlashAttribute("alertMsg", "파일 업로드 실패.");
                    return "redirect:/common/errorPage";
                }
                posterImage = new Image();
                posterImage.setImgType(boardCode);
                posterImage.setOriginName(file.getOriginalFilename());
                posterImage.setChangeName(newChangeName);
                posterImage.setImgOrder(1); 
                posterImage.setImgNo(existingImgNo); 

            } else { // 2. 새로운 파일이 업로드되지 않은 경우
                if (existingImgNo != 0) { 
                    if (existingImgNo == -1) {
                        log.debug("existingImgNo = -1. 기존 이미지 삭제 요청.");
                        if (oldChangeName != null && !oldChangeName.isEmpty()) {
                            deleteFileFromServer(oldChangeName, application);
                        }
                        posterImage = new Image();
                        posterImage.setImgNo(-1);
                    } else {
                        log.debug("existingImgNo = {}. 기존 이미지 유지 요청.", existingImgNo);
                    }
                }
            }
            
            Integer writerUserNo = promoService.selectWriterUserNoByPromoId(promo.getPromoId());

            boolean isAdmin = loginUser.getAuthorities().stream()
                                     .anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuthority()));

            if (writerUserNo == null || (loginUser.getUserNo() != writerUserNo.intValue() && !isAdmin)) {
                ra.addFlashAttribute("alertMsg", "수정 권한이 없습니다.");
                return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId();
            }

            int result = promoService.updatePromo(promo, posterImage);

            if (result > 0) {
                ra.addFlashAttribute("alertMsg", "게시글이 수정되었습니다.");
                return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId();
            }

            ra.addFlashAttribute("alertMsg", "수정에 실패했습니다.");
            ra.addFlashAttribute("promo", promo);
            return "redirect:/promoBoard/promoUpdate?promoId=" + promo.getPromoId();

        } catch (RuntimeException e) {
            log.error("게시글 수정 중 오류", e);
            ra.addFlashAttribute("alertMsg", getExceptionMessage(e));
            return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId();
        }
    }

    // 삭제 처리
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deletePromo(
        @RequestParam("promoId") int promoId,
        Authentication authentication
    ) {
        Map<String, String> response = new HashMap<>();

        UserExt loginUser = getLoginUser(authentication);
        if (loginUser == null) {
            response.put("msg", "fail");
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        Integer writerUserNo = promoService.selectWriterUserNoByPromoId(promoId);
        boolean isAdmin = loginUser.getAuthorities().stream()
                                   .anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuthority()));

        if (writerUserNo == null || (loginUser.getUserNo() != writerUserNo.intValue() && !isAdmin)) {
            response.put("msg", "fail");
            response.put("message", "삭제 권한이 없습니다.");
            return ResponseEntity.status(403).body(response);
        }
        
        // 1. DB에서 이미지 정보 조회
        PromoBoardVo promoToDelete = promoService.selectPromoDetail(promoId);
        String changeNameToDelete = null;
        if (promoToDelete != null && promoToDelete.getPosterImage() != null) {
            changeNameToDelete = promoToDelete.getPosterImage().getChangeName();
        }

        try {
            // 2. 서비스 호출하여 DB에서 게시글 및 이미지 정보 삭제
            int result = promoService.deletePromo(promoId, boardCode);

            if (result > 0) {
                // 3. DB 삭제 성공 시, 서버에서 실제 파일 삭제
                if (changeNameToDelete != null && !changeNameToDelete.isEmpty()) {
                    deleteFileFromServer(changeNameToDelete, application);
                    log.info("게시글 삭제 성공 후 이미지 파일 삭제 완료: {}", changeNameToDelete);
                } else {
                    log.info("게시글 삭제 성공, 연결된 이미지 파일 없음.");
                }

                response.put("msg", "success");
                response.put("message", "게시글이 성공적으로 삭제되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("msg", "fail");
                response.put("message", "게시글 삭제에 실패했습니다. 데이터베이스 오류.");
                return ResponseEntity.status(500).body(response);
            }

        } catch (Exception e) {
            log.error("게시글 삭제 중 오류 발생: {}", e.getMessage(), e);
            response.put("msg", "fail");
            response.put("message", "게시글 삭제 중 서버 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }

    private void deleteFileFromServer(String fullWebPathToDelete, ServletContext application) {
        if (fullWebPathToDelete == null || fullWebPathToDelete.isEmpty()) {
            log.warn("삭제할 파일 경로가 비어 있습니다. 삭제를 건너킵니다.");
            return;
        }

        String serverFilePath = application.getRealPath(fullWebPathToDelete);

        if (serverFilePath == null) {
            return; 
        }

        File fileToDelete = new File(serverFilePath);

        if (fileToDelete.exists() && fileToDelete.isFile()) {
            try {
                if (fileToDelete.delete()) {
                    log.info("파일 삭제 성공: {}", serverFilePath);
                } else {
                    log.error("파일 삭제 실패 (권한 문제 또는 다른 프로세스가 파일 사용 중): {}", serverFilePath);
                }
            } catch (SecurityException e) {
                log.error("파일 삭제 중 보안 오류 발생 (권한 문제): {} - {}", serverFilePath, e.getMessage());
            } catch (Exception e) {
                log.error("파일 삭제 중 알 수 없는 오류 발생: {} - {}", serverFilePath, e.getMessage());
            }
        } else {
            log.info("삭제하려는 파일이 존재하지 않거나 파일이 아닙니다: {}", serverFilePath);
        }
    }

    // 공통 - 로그인 사용자 가져오기
    private UserExt getLoginUser(Authentication authentication) {
        if (authentication == null) return null;
        Object principal = authentication.getPrincipal();
        if (principal instanceof UserExt) {
            return (UserExt) principal;
        }
        return null;
    }

    // 공통 - 태그, 제목, 내용 XSS 방지 및 줄바꿈 처리
    private void sanitizePromoFields(PromoBoardVo promo) {
        if (promo.getPromoTitle() != null) {
            promo.setPromoTitle(Utils.XSSHandling(promo.getPromoTitle()));
        }
        if (promo.getPromoDetail() != null) {
            promo.setPromoDetail(Utils.XSSHandling(promo.getPromoDetail()).replace("\r\n", "<br>"));
        }
    }
    // 공통 - 예외 메시지 처리
    private String getExceptionMessage(Exception e) {
        if (e.getMessage() == null || e.getMessage().isEmpty()) {
            return "알 수 없는 오류가 발생했습니다.";
        }
        return e.getMessage();
    }
}