package com.kh.festait.common.service;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.app.model.dao.AppDao;
import com.kh.festait.app.service.AppServiceImple;
import com.kh.festait.common.model.dao.ImageDao;
import com.kh.festait.common.model.vo.Image;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ImageServiceImpl implements ImageService {
	

	@Autowired
	private final ImageDao imgDao;
	
	@Autowired
    private final ServletContext app; // ServletContext 주입

	@Override
	public Image getImageByRefNoAndType(int appId, String boardCode) {
		return imgDao.getImageByRefNoAndType(appId, boardCode);
	}

}
