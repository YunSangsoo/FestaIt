package com.kh.festait.common.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class PageInfo {
	private int totalCount; // 총 게시글 수
    private int currentPage; // 현재 페이지
    private int pageBlock; // 한 페이지 하단에 보여질 페이지 목록 수
    private int boardLimit; // 한 페이지에 보여질 게시글 수

    private int totalPage; // 가장 마지막 페이지
    private int startPage; // 한 페이지 하단에 보여질 첫 페이지 수
    private int endPage; // 한 페이지 하단에 보여질 마지막 페이지 수

    // MyBatis RowBounds 사용 시 필요한 값들
    private int offset; // 조회 시작 위치 (건너뛸 게시글 수)
    private int limit; // 조회할 게시글 수 (boardLimit과 동일)

    public PageInfo(int totalCount, int currentPage, int pageBlock, int boardLimit) {
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        this.pageBlock = pageBlock;
        this.boardLimit = boardLimit;

        // 페이징 관련 값들 계산
        this.totalPage = (int)Math.ceil((double)totalCount / boardLimit);
        this.startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
        this.endPage = startPage + pageBlock - 1;

        // endPage가 maxPage보다 클 경우
        if(endPage > totalPage) {
            endPage = totalPage;
        }

        // offset과 limit 계산 (HashMap에 사용될 값)
        this.offset = (currentPage - 1) * boardLimit;
        this.limit = boardLimit;
    }
}
