package com.kh.festait.bookmark.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.festait.bookmark.model.vo.Bookmark;
import com.kh.festait.bookmark.service.BookmarkService;
import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.user.model.vo.User;

@RestController
@RequestMapping("/bookmark")
public class BookmarkController {

    @Autowired
    private BookmarkService bookmarkService;

    @PostMapping("/add")
    public ResponseEntity<?> addBookmark(@RequestParam("appId") int appId,
                                         Authentication authentication) {
    	User loginUser = (User) authentication.getPrincipal();
    	int userNo = loginUser.getUserNo();
        
        bookmarkService.addBookmark(userNo, appId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeBookmark(@RequestParam("appId") int appId,
                                            Authentication authentication) {
    	if (authentication == null || !authentication.isAuthenticated()) {
    		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("로그인하지 않은 사용자입니다.");
        }
    	
    	User user = (User) authentication.getPrincipal();
        int userNo = user.getUserNo();

        bookmarkService.removeBookmark(userNo, appId);
        return ResponseEntity.ok().build();
    }
    
    public List<EventBoard> setBookmark(List<EventBoard> eventList, Integer userNo){

        List<Bookmark> bookmarkList = bookmarkService.getBookmarkList(userNo);
    	
        for (EventBoard event : eventList) {
        	event.setBookmarkCheck("off");
        	
        	if (bookmarkList != null) {
        		for (Bookmark bookmark : bookmarkList) {
        			if (event.getAppId() == bookmark.getAppId()) {
        				event.setBookmarkCheck("on");
        				break; // 더 이상 비교할 필요 없음
        			}
        		}
        	}
        }
		
    	return eventList;
    }
}