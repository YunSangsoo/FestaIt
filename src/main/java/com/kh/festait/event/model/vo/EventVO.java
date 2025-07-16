package com.kh.festait.event.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class EventVO {
	// 김현주 : 행사 정보 데이터

	private int eventId;
	private String title;
	private String location;
	private String homepage;
	private String imagePath;
	private String content;
	private String category;

	// getter & setter (자동 생성)
	
}

