package com.kh.festait.common.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.common.model.vo.Image;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ImageDaoImpl implements ImageDao {

	@Autowired
	private final SqlSessionTemplate session;

	@Override
	public Image getImageByRefNoAndType(int refNo, String imgType) {

        Map<String, Object> params = new HashMap<>();
        params.put("refNo", refNo);
        params.put("imgType", imgType);
		
		return session.selectOne("img.selectImageByRefNoAndType",params);
	}

	@Override
	public int deleteImageByRefNoAndType(int refNo, String imgType) {
		
        Map<String, Object> params = new HashMap<>();
        params.put("refNo", refNo);
        params.put("imgType", imgType);
        
        
		return session.delete("img.deleteImageByRefNoAndType",params);
	}

	@Override
	public int insertImage(Image image) {
		
		return session.insert("img.insertImage",image);
	}

}
