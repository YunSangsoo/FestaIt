package com.kh.festait.common.model.vo;

import lombok.Data;

@Data
public class PageInfo {
	private int listCount; // 게시글 갯수 (DB에서 가져올거임)
	private int currentPage; // 현재 요청 페이지 (사용자 요청시 보여줌)
	private int pageLimit; // 페이지 번호의 갯수 (하드코딩)
	private int boardLimit; // 한페이지당 보여줄 게시글의 갯수
	
	// 위에 계산해서 구할 수 있음.
	private int maxPage; 
	private int startPage;
	private int endPage;
}
