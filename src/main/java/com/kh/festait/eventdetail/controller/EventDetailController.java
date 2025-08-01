package com.kh.festait.eventdetail.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.eventdetail.model.service.EventDetailService;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;
import com.kh.festait.user.model.vo.User; 
import com.kh.festait.user.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/eventBoard")
@Slf4j
public class EventDetailController {

    @Autowired
    private EventDetailService eventService;

    @Autowired
    private UserService userService;

    @GetMapping("/detail")
    public String selectEventDetail(
            @RequestParam("appId") int appId,
            Model model,
            RedirectAttributes redirectAttributes,
            Authentication authentication
    ) {

    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("appId", appId);
    	
    	int userNoForBookmark = 0; 
    	User loginUserForJsp = null; 

        // 로그인 정보 확인 및 userNo 추출
        if (authentication != null && authentication.isAuthenticated() && !authentication.getName().equals("anonymousUser")) {
            try {
                loginUserForJsp = (User) authentication.getPrincipal();

                if (loginUserForJsp != null && loginUserForJsp.getUserNo() != 0) {
                    userNoForBookmark = loginUserForJsp.getUserNo();
                }
            } catch (ClassCastException e) {
                log.warn("Principal이 예상하는 User 타입이 아님. UserService를 통해 재조회 시도: {}", authentication.getName());
                String username = authentication.getName();
                loginUserForJsp = userService.myPageUserInfo(username);
                if (loginUserForJsp != null && loginUserForJsp.getUserNo() != 0) {
                    userNoForBookmark = loginUserForJsp.getUserNo();
                } else {
                    log.warn("UserService 재조회 실패 또는 userNo 없음: {}", username);
                }
            }
        } else {
            log.debug("로그인되지 않은 사용자 또는 익명 사용자 접근.");
        }

        // 행사 상세 정보 조회
        EventDetailVo event = eventService.selectEventDetail(paramMap);

        if (event != null) {
            if (userNoForBookmark != 0) {
                boolean isBookmarked = eventService.isEventBookmarkedByUser(userNoForBookmark, appId);
                event.setBookmarked(isBookmarked); 
            } else {
                event.setBookmarked(false); 
            }
        }

        if (event == null) {
            redirectAttributes.addFlashAttribute("alertMsg", "해당 행사를 찾을 수 없습니다.");
            log.warn("행사 조회 실패 - appId: {}", appId);
            return "redirect:/eventBoard";
        }

        model.addAttribute("event", event); 
        model.addAttribute("loginUser", loginUserForJsp); 

        return "event/eventDetail";
    }
}
