package com.kh.festait.common.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.session.RowBounds; // RowBounds import 유지 (혹시 모를 경우 대비)

@Data
@NoArgsConstructor
public class PageInfo {

    private int listCount;   // 현재 총 게시글 수
    private int currentPage; // 현재 페이지 (요청한 페이지)
    private int pageLimit;   // 한 페이지 하단에 보여질 페이징바의 페이지 개수
    private int boardLimit;  // 한 페이지에 보여질 게시글의 개수

    private int maxPage;     // 가장 마지막 페이지 (총 페이지 수)
    private int startPage;   // 한 페이지 하단에 보여질 페이징바의 시작 수
    private int endPage;     // 한 페이지 하단에 보여질 페이징바의 끝 수

    private int offset;      // Mybatis OFFSET/LIMIT를 위한 시작 위치
    private int limit;       // Mybatis OFFSET/LIMIT를 위한 개수 (boardLimit와 동일)

    public PageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
        this.listCount = listCount;
        this.currentPage = currentPage;
        this.pageLimit = pageLimit;
        this.boardLimit = boardLimit;

        // maxPage 계산: 총 게시글 수 / 한 페이지당 게시글 수 (올림)
        this.maxPage = (int) Math.ceil((double) listCount / boardLimit);

        // startPage 계산: 페이징 바의 시작 페이지 (예: 1, 11, 21...)
        // (현재 페이지 - 1) / pageLimit * pageLimit + 1
        this.startPage = (currentPage - 1) / pageLimit * pageLimit + 1;

        // endPage 계산: 페이징 바의 끝 페이지 (예: 10, 20, 30...)
        this.endPage = startPage + pageLimit - 1;

        // endPage가 maxPage보다 클 경우, maxPage로 설정
        if (this.endPage > this.maxPage) {
            this.endPage = this.maxPage;
        }

        // offset 계산: 현재 페이지의 시작 게시글 인덱스 (0부터 시작)
        this.offset = (currentPage - 1) * boardLimit;
        // limit 계산: 한 페이지에 가져올 게시글 수 (boardLimit와 동일)
        this.limit = boardLimit;
    }

    // RowBounds는 이제 직접 사용하지 않으므로, 이 메서드는 선택적으로 유지하거나 제거할 수 있습니다.
    // 현재 DAO에서 RowBounds를 제거했으므로, 이 메서드는 사실상 사용되지 않습니다.
    public RowBounds getRowBounds() {
        return new RowBounds(this.offset, this.limit);
    }
}
