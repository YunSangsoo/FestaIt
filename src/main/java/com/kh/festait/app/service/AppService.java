package com.kh.festait.app.service;

import java.util.List;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.model.vo.Image;

public interface AppService {

	int insertApplication(EventApplication eventApplication, List<Image> imgList);

}
