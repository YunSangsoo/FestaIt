package com.kh.festait.common.service;

import com.kh.festait.common.model.vo.Image;

public interface ImageService {

	Image getImageByRefNoAndType(int appId, String boardCode);

}
