package com.kh.festait.common.model.dao;

import com.kh.festait.common.model.vo.Image;

public interface ImageDao {

	Image getImageByRefNoAndType(int refNo, String string);

	int deleteImageByRefNoAndType(int refNo, String string);

	int insertImage(Image posterImage);

}
