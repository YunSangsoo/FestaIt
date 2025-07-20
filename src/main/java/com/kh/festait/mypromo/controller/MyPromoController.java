package com.kh.festait.mypromo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // ⭐️ RedirectAttributes import 추가

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.template.Pagination;
import com.kh.festait.mypromo.model.service.MyPromoService;
import com.kh.festait.mypromo.model.vo.MyPromoVo;
import com.kh.festait.user.model.vo.User; // ⭐️ User 클래스 import

@Controller
@RequestMapping("/mypromo")
public class MyPromoController {

    @Autowired
    private MyPromoService promoService;

    // 내 홍보 게시글 목록 페이지로 이동 및 데이터 조회
    @GetMapping("/list")
    @PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능하도록 설정
    public String selectMyPromoList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
            HttpSession session, // alertMsg 등을 위해 HttpSession은 유지 (RedirectAttributes 사용 시 필요 없음)
            Model model,
            Authentication authentication) {

        // Authentication 객체에서 현재 로그인된 사용자 정보 (User Principal) 가져오기
        User loginUser = (User) authentication.getPrincipal();

        // @PreAuthorize 덕분에 loginUser는 항상 null이 아님.
        // 따라서 "로그인 후 이용해주세요." 메시지 관련 로직은 필요 없습니다.

        int userNo = loginUser.getUserNo(); // User 객체에 getUserNo() 메소드가 있다고 가정

        int listCount = promoService.selectListCount(userNo);

        int pageLimit = 10;
        int boardLimit = 5;
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        Map<String, Object> params = new HashMap<>();
        params.put("userNo", userNo);
        params.put("offset", (pi.getCurrentPage() - 1) * pi.getBoardLimit());
        params.put("limit", pi.getBoardLimit());

        List<MyPromoVo> list = promoService.selectMyPromoList(params);

        model.addAttribute("pi", pi);
        model.addAttribute("list", list);

        return "mypromo/myPromoList";
    }

    // 내 홍보 게시글 상세 페이지 조회
    @GetMapping("/detail")
    public String selectMyPromoDetail(@RequestParam("promoNo") int promoNo, Model model) {
        MyPromoVo promo = promoService.selectMyPromoById(promoNo);

        if (promo != null) {
            model.addAttribute("promo", promo);
            return "mypromo/myPromoDetail";
        } else {
            // ⭐️ 모달 메시지를 위해 model에 alertMsg 추가. JSP에서 이 값을 확인하여 모달 띄우기.
            model.addAttribute("alertMsg", "존재하지 않거나 삭제된 게시글입니다.");
            return "common/errorPage"; // 오류 페이지로 이동 (해당 JSP에서 alertMsg를 처리해야 함)
        }
    }

    // 홍보 게시글 작성 페이지로 이동 (권한 및 계정 상태 확인)
    @GetMapping("/enrollForm")
    @PreAuthorize("isAuthenticated() and hasRole('MANAGER')") // 매니저 권한 필요
    public String enrollForm(HttpSession session, Model model, Authentication authentication, RedirectAttributes redirectAttributes) { // ⭐️ RedirectAttributes 추가
        User loginUser = (User) authentication.getPrincipal();

        // 계정 활성화 상태 확인 (USER.STATUS = 'T')
        if (loginUser != null && !"T".equals(loginUser.getStatus())) {
            // ⭐️ session.setAttribute 대신 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "비활성화된 계정은 홍보글을 작성할 수 없습니다.");
            return "redirect:/mypromo/list";
        }

        return "mypromo/myPromoEnrollForm";
    }

    // 홍보 게시글 작성
    @PostMapping("/insert")
    @PreAuthorize("isAuthenticated() and hasRole('MANAGER')") // 매니저 권한 필요
    public String insertMyPromo(MyPromoVo promo,
                                HttpServletRequest request,
                                HttpSession session,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) { // ⭐️ RedirectAttributes 추가

        User loginUser = (User) authentication.getPrincipal();

        // 계정 활성화 상태 확인 (USER.STATUS = 'T')
        if (!"T".equals(loginUser.getStatus())) {
            // ⭐️ session.setAttribute 대신 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "비활성화된 계정은 홍보글을 작성할 수 없습니다.");
            return "redirect:/mypromo/list";
        }

        promo.setUserNo(loginUser.getUserNo()); // 현재 로그인된 사용자 번호 설정 (User 객체에 getUserNo() 필요)

        // 파일 업로드 로직 (필요시 추가)

        int result = promoService.insertMyPromo(promo);

        if (result > 0) {
            // ⭐️ 성공 메시지도 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 작성되었습니다.");
            return "redirect:/mypromo/list";
        } else {
            // ⭐️ 실패 메시지도 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 작성에 실패했습니다.");
            return "common/errorPage"; // 오류 페이지로 리다이렉트 (해당 JSP에서 alertMsg를 처리해야 함)
        }
    }

    // 홍보 게시글 수정 페이지로 이동
    @GetMapping("/updateForm")
    @PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능
    public String updateMyPromoForm(@RequestParam("promoNo") int promoNo, Model model, HttpSession session, Authentication authentication, RedirectAttributes redirectAttributes) { // ⭐️ RedirectAttributes 추가
        MyPromoVo promo = promoService.selectMyPromoById(promoNo);

        User loginUser = (User) authentication.getPrincipal();

        // 수정 권한 확인:
        // 1. 게시글이 존재해야 하고
        // 2. 계정이 활성화 상태여야 하며
        // 3. 로그인한 사용자의 userNo가 홍보글의 userNo와 일치하거나
        // 4. 로그인한 사용자가 ROLE_MANAGER 권한을 가지고 있어야 함
        if (promo == null || !("T".equals(loginUser.getStatus()) &&
                               (loginUser.getUserNo() == promo.getUserNo() ||
                                authentication.getAuthorities().stream()
                                    .anyMatch(a -> a.getAuthority().equals("ROLE_MANAGER"))))) {
            // ⭐️ session.setAttribute 대신 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없거나 비활성화된 계정입니다.");
            return "redirect:/mypromo/list";
        }

        model.addAttribute("promo", promo);
        return "mypromo/myPromoUpdateForm";
    }

    // 홍보 게시글 수정
    @PostMapping("/update")
    @PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능
    public String updateMyPromo(MyPromoVo promo,
                                HttpServletRequest request,
                                HttpSession session,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) { // ⭐️ RedirectAttributes 추가

        User loginUser = (User) authentication.getPrincipal();

        // 계정 활성화 상태 확인 및 수정 권한 확인
        if (!"T".equals(loginUser.getStatus()) ||
            !(loginUser.getUserNo() == promo.getUserNo() ||
              authentication.getAuthorities().stream()
                  .anyMatch(a -> a.getAuthority().equals("ROLE_MANAGER")))) {
            // ⭐️ session.setAttribute 대신 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없거나 비활성화된 계정입니다.");
            return "redirect:/mypromo/list";
        }

        // 파일 업로드 로직 (수정 시 기존 파일 처리 및 새 파일 저장)

        int result = promoService.updateMyPromo(promo);

        if (result > 0) {
            // ⭐️ 성공 메시지도 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 수정되었습니다.");
            return "redirect:/mypromo/detail?promoNo=" + promo.getPromoNo();
        } else {
            // ⭐️ 실패 메시지도 RedirectAttributes 사용
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 수정에 실패했습니다.");
            return "common/errorPage";
        }
    }

    // 홍보 게시글 삭제 (STATUS를 'N'으로 변경)
    @PostMapping("/delete")
    @ResponseBody
    @PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능
    public Map<String, String> deleteMyPromo(@RequestParam("promoNo") int promoNo,
                                            @RequestParam("userNo") int userNoFromClient, // 클라이언트에서 userNo를 함께 보내는 경우
                                            HttpSession session,
                                            Authentication authentication) {
        Map<String, String> response = new HashMap<>();
        User loginUser = (User) authentication.getPrincipal();

        // 계정 활성화 상태 확인 및 삭제 권한 확인
        if (!"T".equals(loginUser.getStatus()) ||
            !(loginUser.getUserNo() == userNoFromClient ||
              authentication.getAuthorities().stream()
                  .anyMatch(a -> a.getAuthority().equals("ROLE_MANAGER")))) {
            response.put("msg", "권한이 없거나 비활성화된 계정입니다.");
            return response;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("promoNo", promoNo);
        // params.put("userNo", userNoFromClient); // 이 userNo는 서비스/DAO에서 실제 소유자 확인용으로 사용될 수 있습니다.

        int result = promoService.deleteMyPromo(params);

        if (result > 0) {
            response.put("msg", "success");
        } else {
            response.put("msg", "fail");
        }
        return response;
    }
}
