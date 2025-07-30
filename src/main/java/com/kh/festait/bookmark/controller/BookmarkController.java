package com.kh.festait.bookmark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.festait.bookmark.service.BookmarkService;
import com.kh.festait.user.model.vo.User;

@RestController
@RequestMapping("/bookmark")
public class BookmarkController {

    @Autowired
    private BookmarkService bookmarkService;

    @PostMapping("/add")
    public ResponseEntity<?> addBookmark(@RequestParam("appId") int appId,
                                         Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        int userNo = user.getUserNo();
        
        bookmarkService.addBookmark(userNo, appId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeBookmark(@RequestParam("appId") int appId,
                                            Authentication authentication) {
    	User user = (User) authentication.getPrincipal();
        int userNo = user.getUserNo();

        bookmarkService.removeBookmark(userNo, appId);
        return ResponseEntity.ok().build();
    }
}