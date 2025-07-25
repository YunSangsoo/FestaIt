package com.kh.spring.users.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod; // 이 import는 이제 필요 없을 수 있습니다.
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.users.model.service.UsersService;
import com.kh.spring.users.model.vo.UsersVo;

@Controller
@SessionAttributes({"loginUser"})
public class UsersController {

    @Autowired
    private UsersService uService;

    // ⭐⭐⭐ 이 GET 매핑을 삭제하거나 주석 처리해야 합니다. ⭐⭐⭐
    // Spring Security의 login-page 설정과 충돌합니다.
    // @RequestMapping(value = "/users/login", method = RequestMethod.GET)
    // public String loginUsers() {
    //     return "users/login";
    // }

    @PostMapping("/users/login") // 이 매핑은 login-processing-url과 일치하므로 유지
    public ModelAndView login(
            @ModelAttribute UsersVo u,
            ModelAndView mv,
            Model model,
            HttpSession session,
            RedirectAttributes ra) {
        UsersVo loginUser = uService.loginUsers(u);

        if (loginUser != null) {
            model.addAttribute("loginUser", loginUser);
            ra.addFlashAttribute("alertMsg", "로그인 성공!");
        } else {
            ra.addFlashAttribute("alertMsg", "로그인 실패!");
        }

        mv.setViewName("redirect:/");
        return mv;
    }

    @GetMapping("/users/logout")
    public String logout(HttpSession session, SessionStatus status) {
        status.setComplete();
        return "redirect:/";
    }

    @GetMapping("/users/insert")
    public String enrollForm() {
        return "users/usersEnrollForm"; // SecurityController와 중복될 수 있으니 주의
    }

    @PostMapping("/users/insert")
    public String insertUsers(UsersVo u,
                              Model model,
                              RedirectAttributes ra) {
        int result = uService.insertUsers(u);

        if (result > 0) {
            ra.addFlashAttribute("alertMsg", "회원가입 성공~^^");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "회원가입 실패~ㅠㅜ");
            return "common/errorPage";
        }
    }

    @GetMapping("/users/myPage")
    public String myPage() {
        return "users/myPage"; // SecurityController와 중복될 수 있으니 주의
    }

    @PostMapping("/users/update")
    public String updateUsers(
            UsersVo u,
            RedirectAttributes ra,
            Model model) {
        int result = uService.updateUsers(u);

        if (result > 0) {
            ra.addFlashAttribute("alertMsg", "내정보 수정 성공");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "회원정보 수정 실패");
            return "common/errorPage";
        }
    }

    @ResponseBody
    @GetMapping("/users/idCheck")
    public String idCheck(String userId) {
        int result = uService.idCheck(userId);
        return result + "";
    }

    @PostMapping("/users/selectOne")
    public ResponseEntity<HashMap<String, Object>> selectOne(String userId) {
        HashMap<String, Object> map = uService.selectOne(userId);

        if (map != null) {
            return ResponseEntity
                    .ok()
                    .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
                    .body(map);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}