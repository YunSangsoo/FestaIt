package com.kh.festait.promoboard.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession; // 사용되지 않아도 임포트가 있어 일단 유지합니다.

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.service.PromoBoardService;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 홍보 게시판 웹 요청 처리 컨트롤러
@Controller
@RequiredArgsConstructor
@RequestMapping("/promoBoard")
@Slf4j
public class PromoBoardController {

    private final PromoBoardService promoService;

    // 홍보 게시글 목록 조회 및 검색 결과 조회 통합 (GET /promoBoard)
    @GetMapping
    public String selectPromotionList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {

        log.info("홍보 게시글 목록/검색 요청 - 현재 페이지: {}, 파라미터: {}", currentPage, paramMap);

        PageInfo pi;
        List<PromoBoardVo> list;

        String searchKeyword = (String) paramMap.get("searchKeyword");
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            pi = promoService.getSearchPromoPageInfo(currentPage, paramMap);
            list = promoService.searchPromo(paramMap, pi);
        } else {
            pi = promoService.getPromoPageInfo(currentPage);
            list = promoService.getPromoList(pi, paramMap);
        }

        log.info("조회된 게시글 목록 (list) 크기: {}", list.size());
        for (PromoBoardVo promo : list) {
            log.info("게시글 정보: PROM_ID={}, PROM_TITLE={}, POSTER_PATH={}",
                     new Object[]{promo.getPromoId(), promo.getPromoTitle(), promo.getPosterPath()});
        }

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("param", paramMap);

        return "promotion/promoBoard";
    }

    // 홍보 게시글 상세 조회 (GET /promoBoard/detail)
    @GetMapping("/detail")
    public String selectPromoDetail(
            @RequestParam("promoId") int promoId,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.info("홍보 상세 페이지 요청 - 게시글 번호: {}", promoId);

        int result = promoService.increasePromoViews(promoId);

        PromoBoardVo promo = null;
        if (result > 0) {
            promo = promoService.selectPromotionDetail(promoId);
        }

        if (promo != null) {
            model.addAttribute("promo", promo);
            log.info("홍보 상세 조회 성공: {}", promo);
            return "promotion/promoDetail";
        } else {
            log.warn("홍보 게시물을 찾기 실패: 게시글 번호 {}", promoId);
            redirectAttributes.addFlashAttribute("alertMsg", "해당 홍보 게시물을 찾을 수 없습니다.");
            return "redirect:/promoBoard";
        }
    }

    // 홍보 게시글 작성 페이지로 이동 (GET /promoBoard/promoWrite)
    @GetMapping("/promoWrite")
    public String enrollForm(
            @RequestParam(value = "appId", required = false) Integer appId, // URL 쿼리 파라미터로 appId를 받음
            Model model) {

        if (appId != null && appId > 0) {
            model.addAttribute("selectedEventAppId", appId); // JSP로 appId를 전달
            log.info("홍보 게시글 작성 페이지로 이동 - 전달된 APP_ID: {}", appId);
        } else {
            // ⭐ 중요: 유효한 appId가 없을 경우 처리 ⭐
            // 여기서는 임시로 고정된 기본값 1을 넣어주는 예시입니다.
            // 실제 프로젝트에서는 유효한 이벤트 ID를 선택하도록 유도하거나,
            // 기본 이벤트 ID를 설정하는 등의 비즈니스 로직이 필요합니다.
            log.warn("홍보 게시글 작성 페이지로 이동 - 유효한 APP_ID가 전달되지 않았습니다. 기본 APP_ID 1로 설정합니다.");
            model.addAttribute("selectedEventAppId", 1); // 임시로 기본 APP_ID를 1로 설정
        }
        return "promotion/promoWrite";
    }

    // 홍보 게시글 작성 처리 (POST /promoBoard/promoWrite)
    @PostMapping("/promoWrite")
    public String insertMyPromo(PromoBoardVo promo, // promo.appId는 폼에서 자동으로 바인딩됨 (Hidden 필드)
                                 @RequestParam(value = "promoPoster", required = false) MultipartFile promoPoster,
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes) {

        log.info("홍보 게시글 작성 요청: {}", promo);
        log.info("업로드된 파일: {}", promoPoster != null ? promoPoster.getOriginalFilename() : "없음");
        log.info("업로드된 파일 크기: {} bytes", promoPoster != null ? promoPoster.getSize() : 0);
        
        // ⭐ 추가: promo 객체에 바인딩된 appId 값 로그 확인 ⭐
        // 이 로그를 통해 promoWrite.jsp에서 Hidden 필드로 전달된 appId가 컨트롤러에서 제대로 바인딩되었는지 확인합니다.
        log.info("Controller - insertMyPromo 호출 시 promo.getAppId(): {}", promo.getAppId());

        String webPath = "/resources/images/";
        String realPath = request.getSession().getServletContext().getRealPath(webPath);
        log.info("파일 저장될 웹 경로: {}", webPath);
        log.info("파일 저장될 서버 실제 경로: {}", realPath);

        // 이미지 파일이 업로드된 경우
        if (promoPoster != null && !promoPoster.isEmpty()) {
            String originalFilename = promoPoster.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String changeName = System.currentTimeMillis() + ext; // 변경된 파일명 (시간 기반)

            try {
                File targetFile = new File(realPath + changeName);
                if (!targetFile.getParentFile().exists()) { // 디렉토리가 없으면 생성
                    log.info("파일 저장 디렉토리 생성: {}", targetFile.getParentFile().getAbsolutePath());
                    targetFile.getParentFile().mkdirs();
                }
                promoPoster.transferTo(targetFile); // 파일 저장

                promo.setPosterPath(webPath + changeName); // DB에 저장할 변경된 파일명 (경로 포함)
                promo.setOriginalFilename(originalFilename); // DB에 저장할 원본 파일명

                log.info("파일 업로드 성공: 서버 저장 경로: {}", targetFile.getAbsolutePath());
                log.info("DB에 저장될 posterPath: {}", promo.getPosterPath());
                log.info("DB에 저장될 originalFilename: {}", promo.getOriginalFilename());

            } catch (IOException e) {
                log.error("파일 업로드 실패: {}", e.getMessage(), e); // 스택 트레이스 출력
                redirectAttributes.addFlashAttribute("alertMsg", "파일 업로드에 실패했습니다.");
                return "common/errorPage"; // 오류 페이지로 이동
            }
        } else {
            promo.setPosterPath(null); // 파일이 업로드되지 않은 경우 null로 설정
            promo.setOriginalFilename(null);
            log.info("업로드된 파일 없음. posterPath 및 originalFilename을 null로 설정.");
        }

        // 서비스 호출 직전, promo 객체의 내용 및 이미지 필드 값 확인
        log.info("서비스 호출 전 promo.promoTitle: {}", promo.getPromoTitle());
        log.info("서비스 호출 전 promo.promoDetail: {}", promo.getPromoDetail());
        log.info("서비스 호출 전 promo.posterPath: {}", promo.getPosterPath());
        log.info("서비스 호출 전 promo.originalFilename: {}", promo.getOriginalFilename());

        // 서비스 호출 (이미지 및 URL 처리를 포함한 통합 로직)
        // promo.appId는 @ModelAttribute에 의해 이미 설정되어 서비스로 전달됩니다.
        int result = promoService.insertPromoWithImageAndUrl(promo);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 작성되었습니다.");
            return "redirect:/promoBoard";
        } else {
            // Service에서 0을 반환했을 때의 오류 메시지 (APP_ID 유효성 검사 실패 등)
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 작성에 실패했습니다. 유효한 이벤트 정보가 없거나 다른 오류가 발생했습니다.");
        }
        return "common/errorPage"; // 오류 페이지로 이동
    }

    // 홍보 게시글 수정 페이지로 이동 (GET /promoBoard/promoUpdate)
    @GetMapping("/promoUpdate")
    public String updateMyPromoForm(
            @RequestParam(value = "promoId", required = false) Integer promoId,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (promoId == null) {
            redirectAttributes.addFlashAttribute("alertMsg", "수정할 게시글 번호가 지정되지 않았습니다.");
            return "redirect:/promoBoard";
        }

        PromoBoardVo promo = promoService.selectPromotionDetail(promoId);

        if (promo == null) {
            redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없거나 존재하지 않는 게시글입니다.");
            return "redirect:/promoBoard";
        }

        model.addAttribute("promo", promo);
        return "promotion/promoUpdate";
    }

    // 홍보 게시글 수정 처리 (POST /promoBoard/update)
    @PostMapping("/update")
    public String updateMyPromo(PromoBoardVo promo,
                                 @RequestParam(value = "promoPoster", required = false) MultipartFile promoPoster,
                                 @RequestParam(value = "originalPromoPosterPath", required = false) String originalPromoPosterPath, // 기존 파일 경로 (웹 경로)
                                 @RequestParam(value = "deleteOriginalImage", required = false) String deleteOriginalImage, // 기존 이미지 삭제 체크박스
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes) {

        log.info("홍보 게시글 수정 요청: {}", promo);
        log.info("업로드된 새 파일: {}", promoPoster != null ? promoPoster.getOriginalFilename() : "없음");
        log.info("업로드된 새 파일 크기: {} bytes", promoPoster != null ? promoPoster.getSize() : 0);
        log.info("기존 포스터 경로 (originalPromoPosterPath): {}", originalPromoPosterPath);
        log.info("기존 이미지 삭제 체크박스 (deleteOriginalImage): {}", deleteOriginalImage);

        String webPath = "/resources/images/";
        String realPath = request.getSession().getServletContext().getRealPath(webPath);
        log.info("파일 저장될 웹 경로: {}", webPath);
        log.info("파일 저장될 서버 실제 경로: {}", realPath);

        String updatedPosterPath = originalPromoPosterPath; // 기본적으로 기존 경로 유지
        String updatedOriginalFilename = promo.getOriginalFilename(); // 기존 VO의 원본 파일명 유지

        // 1. 새 파일이 업로드된 경우
        if (promoPoster != null && !promoPoster.isEmpty()) {
            log.info("새 파일이 업로드됨: {}", promoPoster.getOriginalFilename());
            // 기존 파일이 있다면 서버에서 삭제 (DB 참조 카운트는 서비스에서 처리)
            if (originalPromoPosterPath != null && !originalPromoPosterPath.isEmpty()) {
                File deleteFile = new File(request.getSession().getServletContext().getRealPath(originalPromoPosterPath));
                if (deleteFile.exists()) {
                    if (deleteFile.delete()) {
                        log.info("기존 파일 삭제 성공: {}", originalPromoPosterPath);
                    } else {
                        log.warn("기존 파일 삭제 실패: {}", originalPromoPosterPath);
                    }
                }
            }

            // 새 파일 저장
            String originalFilename = promoPoster.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String changeName = System.currentTimeMillis() + ext;
            try {
                File targetFile = new File(realPath + changeName);
                if (!targetFile.getParentFile().exists()) {
                    log.info("파일 저장 디렉토리 생성 (수정): {}", targetFile.getParentFile().getAbsolutePath());
                    targetFile.getParentFile().mkdirs();
                }
                promoPoster.transferTo(targetFile);
                updatedPosterPath = webPath + changeName; // 업데이트될 경로
                updatedOriginalFilename = originalFilename; // 새 원본 파일명 설정
                log.info("새 파일 업로드 및 경로 설정 성공 (수정): 서버 저장 경로: {}", targetFile.getAbsolutePath());
                log.info("DB에 저장될 posterPath (수정): {}", updatedPosterPath);
                log.info("DB에 저장될 originalFilename (수정): {}", updatedOriginalFilename);
            } catch (IOException e) {
                log.error("파일 업로드 실패 (수정): {}", e.getMessage(), e); // 스택 트레이스 출력
                redirectAttributes.addFlashAttribute("alertMsg", "파일 업로드에 실패했습니다.");
                return "common/errorPage"; // 오류 페이지로 이동
            }
        }
        // 2. 새 파일은 없고 기존 이미지 삭제 체크박스가 체크된 경우
        else if ("true".equals(deleteOriginalImage)) {
            log.info("기존 이미지 삭제 체크박스 선택됨.");
            // 기존 파일이 있다면 서버에서 삭제 (DB 참조 카운트는 서비스에서 처리)
            if (originalPromoPosterPath != null && !originalPromoPosterPath.isEmpty()) {
                File deleteFile = new File(request.getSession().getServletContext().getRealPath(originalPromoPosterPath));
                if (deleteFile.exists()) {
                    if (deleteFile.delete()) {
                        log.info("기존 파일 삭제 성공 (체크박스): {}", originalPromoPosterPath);
                    } else {
                        log.warn("기존 파일 삭제 실패 (체크박스): {}", originalPromoPosterPath);
                    }
                }
            }
            updatedPosterPath = null; // DB에서 이미지 경로를 null로 설정
            updatedOriginalFilename = null; // 원본 파일명도 null로 설정
            log.info("posterPath 및 originalFilename을 null로 설정.");
        }
        // 3. 새 파일도 없고, 기존 이미지 삭제 체크박스도 체크되지 않은 경우 (기존 이미지 유지)
        else {
            log.info("새 파일 없음, 삭제 체크 안 됨. 기존 posterPath 유지: {}", updatedPosterPath);
        }

        promo.setPosterPath(updatedPosterPath); // 최종적으로 업데이트될 posterPath 설정
        promo.setOriginalFilename(updatedOriginalFilename); // 최종적으로 업데이트될 originalFilename 설정

        // 서비스 호출 (이미지 및 URL 처리를 포함한 통합 로직)
        int result = promoService.updatePromoWithImageAndUrl(promo);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 수정되었습니다.");
            return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId();
        } else {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 수정에 실패했습니다.");
            return "common/errorPage"; // 오류 페이지로 이동
        }
    }

    // 홍보 게시글 삭제 처리 (POST /promoBoard/delete)
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, String> deleteMyPromo(@RequestParam("promoId") int promoId, HttpServletRequest request) {

        Map<String, String> response = new HashMap<>();
        // Map<String, Object> params = new HashMap<>(); // 사용되지 않으므로 제거 가능.
        // params.put("promoId", promoId); // 사용되지 않으므로 제거 가능.

        // 삭제 전 기존 이미지 경로 및 이미지 번호 조회 (실제 파일 삭제를 위해 필요)
        PromoBoardVo promoToDelete = promoService.selectPromotionDetail(promoId);
        String posterPathToDelete = null;
        // int imgNoToDelete = 0; // 이 변수는 이제 서비스 계층으로 전달되지 않으므로 필요하지 않습니다.

        if (promoToDelete != null) {
            posterPathToDelete = promoToDelete.getPosterPath();
            // imgNoToDelete = promoToDelete.getImgNo(); // 서비스 메서드 시그니처 변경으로 더 이상 필요 없음
            log.info("삭제할 게시글의 기존 이미지 정보 - promoId: {}, posterPath: {}",
                     new Object[]{promoId, posterPathToDelete});
        } else {
            log.warn("삭제할 게시글 정보를 찾을 수 없습니다: promoId {}", promoId);
        }

        // 서비스 호출 (이미지 및 URL 처리를 포함한 통합 로직)
        // 서비스 메서드 시그니처가 (int promoId)로 변경되었으므로, promoId만 전달합니다.
        int result = promoService.deletePromoWithImageAndUrl(promoId); // ★★★ 이 줄을 수정했습니다 ★★★

        if (result > 0) {
            // DB 삭제 성공 시, 서버에서 실제 파일 삭제 (단, 해당 이미지가 다른 곳에서 참조되지 않는 경우에만)
            // 서비스에서 이미 DB의 IMAGE 레코드를 삭제하고 있으므로,
            // 이제 컨트롤러에서는 해당 파일이 실제로 서버에 존재한다면 삭제하는 로직만 수행하면 됩니다.
            // (서비스에서 참조 이미지 보호 로직을 처리했기 때문에, 여기에선 단순 삭제 시도)
            if (posterPathToDelete != null && !posterPathToDelete.isEmpty()) {
                File deleteFile = new File(request.getSession().getServletContext().getRealPath(posterPathToDelete));
                if (deleteFile.exists()) {
                    if (deleteFile.delete()) {
                        log.info("게시글 삭제와 함께 파일 삭제 성공 (파일 시스템): {}", posterPathToDelete);
                    } else {
                        log.warn("게시글 삭제 시 파일 삭제 실패 (파일 시스템): {}", posterPathToDelete);
                    }
                } else {
                    log.info("삭제할 파일이 서버에 존재하지 않습니다: {}", posterPathToDelete);
                }
            } else {
                log.info("삭제할 이미지 경로가 없으므로 파일 시스템 삭제 건너뜀.");
            }
            response.put("msg", "success");
        } else {
            response.put("msg", "fail");
        }
        return response;
    }
}

