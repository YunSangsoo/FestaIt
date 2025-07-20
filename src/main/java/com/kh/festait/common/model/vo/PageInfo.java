package com.kh.festait.common.model.vo;

import lombok.Data; // Lombok 사용 시
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data // @Data 어노테이션이 getter, setter를 자동으로 생성해 줍니다.
@NoArgsConstructor
@AllArgsConstructor
public class PageInfo {

    private int listCount;       // 총 게시글 개수
    private int currentPage;     // 현재 페이지
    private int pageLimit;       // 한 페이지 하단에 보여질 페이징바 개수
    private int boardLimit;      // 한 페이지에 보여질 게시글 최대 개수

    private int maxPage;         // 총 페이지 중에서 가장 마지막 페이지
    private int startPage;       // 현재 페이지 하단에 보여질 페이징바의 시작 수
    private int endPage;         // 현재 페이지 하단에 보여질 페이징바의 끝 수

    // ⭐ 추가해야 할 필드 및 해당 getter (Lombok의 @Data가 자동으로 생성) ⭐
    private int offset;          // Mybatis RowBounds 또는 OFFSET/LIMIT를 위한 시작 위치
    private int limit;           // Mybatis RowBounds 또는 OFFSET/LIMIT를 위한 개수

    // Pagination.getPageInfo() 메서드에서 이 필드들을 계산하여 PageInfo 객체에 세팅해야 합니다.
    // 예를 들어, Pagination 클래스 내에서 getPageInfo 메서드는 다음과 같이 동작해야 합니다:
    /*
    public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
        // ... (기존 maxPage, startPage, endPage 계산 로직)

        PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
        pi.setOffset((currentPage - 1) * boardLimit); // offset 계산 및 설정
        pi.setLimit(boardLimit); // limit 설정
        return pi;
    }
    */
}