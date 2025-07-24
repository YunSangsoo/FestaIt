package com.kh.festait.common.template;

import com.kh.festait.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		PageInfo pi= new PageInfo();
		pi.setTotalCount(listCount);     // listCount → totalCount
		pi.setPageBlock(pageLimit);      // pageLimit → pageBlock
		pi.setBoardLimit(boardLimit);
		pi.setCurrentPage(currentPage);
		
		// 1. 최대 페이지 개수
		int maxPage = (int)Math.ceil((double) listCount/boardLimit);
		
		// 2. 시작 페이지
		int startPage = (currentPage - 1 )/ pageLimit * pageLimit +1;
		
		// 3. 종료 페이지
		int endPage = startPage + pageLimit -1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		pi.setStartPage(startPage);
		pi.setEndPage(endPage);
		pi.setTotalPage(maxPage);
		
		
		return pi;
	}

}
