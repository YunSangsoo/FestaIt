package com.kh.festait.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.festait.app.model.dao.AppDao;
import com.kh.festait.app.model.vo.AppManager;
import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.Utils;
import com.kh.festait.common.model.dao.ImageDao;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.model.vo.PageInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AppServiceImple implements AppService {
	
	@Autowired
	private final AppDao appDao;
	
	@Autowired
	private final ImageDao imgDao;
	
	@Autowired
    private final ServletContext app; // ServletContext 주입

	@Override
	public EventApplication getEvAppById(int appId) { 
		return appDao.getEvAppById(appId);
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int saveOrUpdateApplication(EventApplication eventApplication) {
		int result = 0, result2=0;
		
		eventApplication.setAppTitle(Utils.XSSHandling(eventApplication.getAppTitle()));
		eventApplication.setAppSubTitle(Utils.XSSHandling(eventApplication.getAppSubTitle()));
		eventApplication.setAppDetail(Utils.XSSHandling(eventApplication.getAppDetail()));
		eventApplication.setAppDetail(Utils.newLineHandling(eventApplication.getAppDetail()));
		eventApplication.setLocation(Utils.XSSHandling(eventApplication.getLocation()));
		eventApplication.setLocationDetail(Utils.XSSHandling(eventApplication.getLocationDetail()));
		eventApplication.setPostCode(Utils.XSSHandling(eventApplication.getPostCode()));
		eventApplication.setWebsite(Utils.XSSHandling(eventApplication.getWebsite()));
		eventApplication.setStartTime(Utils.XSSHandling(eventApplication.getStartTime()));
		eventApplication.setEndTime(Utils.XSSHandling(eventApplication.getEndTime()));
		eventApplication.setAppFee(Utils.XSSHandling(eventApplication.getAppFee()));
		eventApplication.setAppItem(Utils.XSSHandling(eventApplication.getAppItem()));
		eventApplication.setAppHost(Utils.XSSHandling(eventApplication.getAppHost()));
		eventApplication.setAppOrg(Utils.XSSHandling(eventApplication.getAppOrg()));
		eventApplication.setAppSponser(Utils.XSSHandling(eventApplication.getAppSponser()));
		
		AppManager inputManager = eventApplication.getAppManager(); 
		
		inputManager.setManagerName(Utils.XSSHandling(inputManager.getManagerName()));
		inputManager.setEmail(Utils.XSSHandling(inputManager.getEmail()));
		inputManager.setTel(Utils.XSSHandling(inputManager.getTel()));
		inputManager.setFax(Utils.XSSHandling(inputManager.getFax()));
		
		if (eventApplication.getAppId() == 0) {
            result = appDao.insertApplication(eventApplication); // INSERT 메서드
        } else {
            result = appDao.updateApplication(eventApplication); // UPDATE 메서드
        }
		

		if (eventApplication.getAppManager().getAppId() == 0) {
            result2 = appDao.insertAppManager(eventApplication); // INSERT 메서드
        } else {
            result2 = appDao.updateAppManager(eventApplication); // UPDATE 메서드
        }
		
		
		// 이미지 처리
		Image posterImage = eventApplication.getPosterImage();
        
        // PosterImage에 appId (refNo) 설정
        if (posterImage != null) {
            posterImage.setRefNo(eventApplication.getAppId());
        }
        
        int imageResult=1;
        // 기존 이미지 삭제 또는 새로운 이미지 등록 로직
        if (posterImage != null && posterImage.getImgNo() == -1) { // -1은 JSP에서 'X' 버튼 클릭으로 삭제 요청한 경우
            // 기존 이미지 정보 조회 (물리 파일 삭제를 위함)
            Image existingPoster = imgDao.getImageByRefNoAndType(posterImage.getRefNo(), "A");
            if (existingPoster != null) {
                imageResult = imgDao.deleteImageByRefNoAndType(posterImage.getRefNo(), "A");
                if (imageResult > 0) { // DB 삭제 성공 시 물리 파일도 삭제
                    // Utils.deleteFile 함수 호출
                    boolean isDeleted = Utils.deleteFile(existingPoster.getChangeName(), app, "eventPoster");
                    if (!isDeleted) {
                    	log.error("물리 파일 삭제 : {}",existingPoster.getChangeName());
                        // 파일 삭제 실패 시에도 트랜잭션 롤백 여부는 비즈니스 로직에 따라 결정
                        // 여기서는 DB는 삭제되었으므로 성공으로 간주하지만, 로그는 남김
                    }
                }
            }
        } else if (posterImage != null && posterImage.getImgNo() == 0) { // 새로운 파일이 업로드된 경우
            // 기존 이미지 정보 확인 (새로운 이미지로 대체하기 위함)
            Image existingPoster = imgDao.getImageByRefNoAndType(posterImage.getRefNo(), "A");
            if (existingPoster != null) {
                // 기존 이미지 DB 삭제
            	imgDao.deleteImageByRefNoAndType(posterImage.getRefNo(), "A");
                // 기존 물리 파일 삭제
                boolean isDeleted = Utils.deleteFile(existingPoster.getChangeName(), app, "eventPoster");
                if (!isDeleted) {
                	log.error("물리 파일 삭제 : {}",existingPoster.getChangeName());
                }
            }
            
            // 새 이미지 INSERT
            imageResult = imgDao.insertImage(posterImage);
        } else { 
        	// posterImage가 null 이거나 (새 파일 없음, 삭제 요청 아님), imgNo가 0이 아닌 경우 (기존 이미지 그대로 유지)
            imageResult = 1; // 이미지를 다루지 않으므로 성공으로 간주
        }

        if (imageResult == 0 && (posterImage != null && posterImage.getImgNo() != -1)) {
            throw new RuntimeException("이미지 저장/업데이트 실패");
        }
		

		return result;
	}
	
	@Override
    public int selectAppListCount() {
        return appDao.selectAppListCount();
    }
	
	@Override
    public List<EventApplication> selectAppList(PageInfo pi) {
        // offset: 몇 개의 게시글을 건너뛸 것인가
        // limit: 몇 개의 게시글을 조회할 것인가 (boardLimit과 동일)

		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("offset", pi.getOffset()); // PageInfo에서 계산된 offset 사용
        paramMap.put("limit", pi.getLimit());   // PageInfo에서 계산된 limit 사용 (boardLimit과 동일)

        return appDao.selectAppList(paramMap);
    }

	@Override
	public int approvingApp(String appId) {
		return appDao.approvingApp(appId);
		
	}

	@Override
	public int rejectingApp(Map<String, String> setMap) {
		
		return appDao.rejectingApp(setMap);
		
	}

}
