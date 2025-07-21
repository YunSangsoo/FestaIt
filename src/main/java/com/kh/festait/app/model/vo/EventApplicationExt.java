package com.kh.festait.app.model.vo;

import java.util.List;

import com.kh.festait.common.model.vo.Image;

import lombok.Data;

@Data
public class EventApplicationExt {
	private List<Image> imgList;
	private String userName;
}
