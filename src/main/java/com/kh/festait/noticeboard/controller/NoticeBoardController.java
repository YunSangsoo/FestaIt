package com.kh.festait.noticeboard.controller;

import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.HttpHeaders;

import com.kh.festait.common.Utils;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.model.dao.ImageDao;
import com.kh.festait.noticeboard.model.service.NoticeBoardService;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/noticeBoard")
@Slf4j
public class NoticeBoardController {

    @Autowired
    private NoticeBoardService noticeBoardService;
    
    @Autowired
    private ImageDao imageDao;
    
    @Autowired
    private ServletContext app;
    

    // 1. 공지 리스트
    @GetMapping("")
    public String noticeList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int limit = 10; 
        int offset = (page - 1) * limit;

        List<NoticeBoard> list = noticeBoardService.selectNoticeList(offset, limit);
        int totalCount = noticeBoardService.getNoticeCount();

        int totalPage = (int) Math.ceil((double) totalCount / limit);
        int pageBlock = 5;
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage)
            endPage = totalPage;

        model.addAttribute("noticeList", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("limit", limit);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "noticeBoard/noticeBoardList";
    }

    // 2. 공지사항 상세 보기
    @GetMapping("/detail")
    public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
        NoticeBoard notice = noticeBoardService.selectNoticeById(noticeId);
        
        // 이미지 정보 조회 (refNo = noticeId, type = "N")
        Image noticeImage = imageDao.getImageByRefNoAndType(noticeId, "N");
        model.addAttribute("notice", notice);
        model.addAttribute("noticeImage", noticeImage);
        
        notice.setPosterImage(noticeImage);

        log.info("notice : {}",notice);
        log.info("image : {}",noticeImage);
        return "noticeBoard/noticeDetail";
    }

    // 3. 작성 폼
    @GetMapping("/noticeWrite")
    public String showWriteForm(Model model) {
        model.addAttribute("notice", new NoticeBoard());
        return "noticeBoard/noticeWrite";
    }

    @PostMapping("/create")
    public String createNotice(NoticeBoard notice,
                               @RequestParam(value="noticeFile", required=false) MultipartFile noticeFile,
                               HttpServletRequest request,
                               RedirectAttributes ra) {

        notice.setNoticeTitle(Utils.XSSHandling(notice.getNoticeTitle()));
        notice.setNoticeDetail(Utils.newLineHandling(Utils.XSSHandling(notice.getNoticeDetail())));
        
        int result = noticeBoardService.insertNotice(notice);

        if (result > 0 && noticeFile != null && !noticeFile.isEmpty()) {
            String savedFileName = Utils.saveFile(noticeFile, request.getServletContext(), "notice");
            
            Image img = new Image();
            img.setRefNo(notice.getNoticeId()); // 공지 ID 넣기
            img.setImgType("N"); // notice 타입 지정
            img.setOriginName(noticeFile.getOriginalFilename());
            img.setChangeName(savedFileName);

            imageDao.insertImage(img);
        }

        ra.addFlashAttribute("msg", result > 0 ? "등록 완료" : "등록 실패");
        return "redirect:/noticeBoard";
    }

    // 4. 수정
    @PostMapping("/update")
    public String updateNotice(NoticeBoard notice,
                               @RequestParam(value="noticeFile", required=false) MultipartFile noticeFile,
                               @RequestParam(value="deleteFile", required=false, defaultValue="false") boolean deleteFile,
                               HttpServletRequest request,
                               RedirectAttributes ra) {

        notice.setNoticeTitle(Utils.XSSHandling(notice.getNoticeTitle()));
        notice.setNoticeDetail(Utils.newLineHandling(Utils.XSSHandling(notice.getNoticeDetail())));

        // 이미지 정보 조회
        Image existingImage = imageDao.getImageByRefNoAndType(notice.getNoticeId(), "N");

        if (deleteFile) {
            if (existingImage != null) {
                imageDao.deleteImageByRefNoAndType(notice.getNoticeId(), "N");
                Utils.deleteFile(existingImage.getChangeName(), request.getServletContext(), "notice");
            }
        } else if (noticeFile != null && !noticeFile.isEmpty()) {
            // 새 파일 업로드 시 기존 파일 삭제 후 저장
            if (existingImage != null) {
                imageDao.deleteImageByRefNoAndType(notice.getNoticeId(), "N");
                Utils.deleteFile(existingImage.getChangeName(), request.getServletContext(), "notice");
            }

            String savedFileName = Utils.saveFile(noticeFile, request.getServletContext(), "notice");
            Image img = new Image();
            img.setRefNo(notice.getNoticeId());
            img.setImgType("N");
            img.setOriginName(noticeFile.getOriginalFilename());
            img.setChangeName(savedFileName);

            imageDao.insertImage(img);
        }
        // else 파일 변경 없으면 그대로 유지

        int result = noticeBoardService.updateNotice(notice);
        ra.addFlashAttribute("msg", result > 0 ? "수정 완료" : "수정 실패");
        return "redirect:/noticeBoard/detail?noticeId=" + notice.getNoticeId();
    }
    
    // 5. 파일 다운로드
    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(@RequestParam("filePath") String filePath) throws Exception {
        if (filePath.startsWith("/")) {
            filePath = filePath.substring(1);
        }

        // filePath에 불필요한 경로가 포함되어 있다면 제거 (정규화 처리)
        if (filePath.contains("resources/img/notice/")) {
            filePath = filePath.substring(filePath.indexOf("resources/img/notice/") + "resources/img/notice/".length());
        }

        // 실제 저장 경로 (웹 루트 기준)
        String baseDir = app.getRealPath("/resources/img/notice/");
        Path fullPath = Paths.get(baseDir).resolve(filePath).normalize();

        Resource resource = new UrlResource(fullPath.toUri());
        
        /*
        // resources/upload/notice 경로가 중복된 경우 제거
        String basePathSegment = "resources/img/notice/";
    
        if (filePath.startsWith(basePathSegment)) {
            filePath = filePath.substring(basePathSegment.length());
        }

        String baseDir = app.getRealPath("/resources/img/notice/");
        Path fullPath = Paths.get(baseDir).resolve(filePath).normalize();
        
        log.info("path : {}",fullPath);
        Resource resource = new UrlResource(fullPath.toUri());
        
        */

        if (!resource.exists() || !resource.isReadable()) {
            throw new FileNotFoundException("파일을 찾을 수 없습니다: " + fullPath.toString());
        }

        String fileName = fullPath.getFileName().toString();
        String encodedFilename = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFilename)
                .body(resource);
    }
    
    // 6. 공지 삭제
    @PostMapping("/delete")
    public String deleteNotice(@RequestParam("noticeId") int noticeId, HttpServletRequest request, RedirectAttributes ra) {
        NoticeBoard notice = noticeBoardService.selectNoticeById(noticeId);
        
        Image existingImage = imageDao.getImageByRefNoAndType(noticeId, "N");
        if (existingImage != null) {
            imageDao.deleteImageByRefNoAndType(noticeId, "N");
            Utils.deleteFile(existingImage.getChangeName(), request.getServletContext(), "notice");
        }

        int result = noticeBoardService.deleteNotice(noticeId);
        ra.addFlashAttribute("msg", result > 0 ? "삭제 완료" : "삭제 실패");
        return "redirect:/noticeBoard";
    }

}
