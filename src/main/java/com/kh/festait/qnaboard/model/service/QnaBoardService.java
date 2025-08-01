package com.kh.festait.qnaboard.model.service;

import com.kh.festait.qnaboard.model.vo.QnaBoard;

import java.util.List;

public interface QnaBoardService {

    void insertQna(QnaBoard qna);  // 문의 작성

    List<QnaBoard> selectQnaList(String viewMode, int userNo, int page);  // 목록 조회

    QnaBoard selectQnaById(int id);  // 상세 조회

    int getTotalPage(String viewMode, int userNo);  // 전체 페이지 수 계산

	void updateAnswer(int qnaId, String answerDetail); //답변
}