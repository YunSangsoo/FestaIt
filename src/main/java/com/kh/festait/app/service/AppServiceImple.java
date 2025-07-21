package com.kh.festait.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.festait.app.model.dao.AppDao;
import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.Utils;
import com.kh.festait.common.model.vo.Image;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AppServiceImple implements AppService {
	
	private final AppDao appDao;

	@Override
	public int insertApplication(EventApplication eventApplication, List<Image> imgList) {
		
		eventApplication.setAppTitle(Utils.XSSHandling(eventApplication.getAppTitle()));
		eventApplication.setAppSubTitle(Utils.XSSHandling(eventApplication.getAppSubTitle()));
		eventApplication.setAppDetail(Utils.XSSHandling(eventApplication.getAppDetail()));
		eventApplication.setAppDetail(Utils.newLineHandling(eventApplication.getAppDetail()));
		eventApplication.setLocation(Utils.XSSHandling(eventApplication.getLocation()));
		eventApplication.setLocationDetail(Utils.XSSHandling(eventApplication.getLocationDetail()));
		eventApplication.setPostcode(Utils.XSSHandling(eventApplication.getPostcode()));
		eventApplication.setWebsite(Utils.XSSHandling(eventApplication.getWebsite()));
		eventApplication.setAppTitle(Utils.XSSHandling(eventApplication.getAppTitle()));
		eventApplication.setAppTitle(Utils.XSSHandling(eventApplication.getAppTitle()));
		
		
		return 0;
	}

}
