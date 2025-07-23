package com.kh.festait.common;

import com.kh.festait.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int totalCount, int page, int limit, int pageBlock) {
        // PageInfo 객체를 생성하여 페이징 관련 모든 정보 계산
        return new PageInfo(totalCount, page, limit, pageBlock);
    }

}
