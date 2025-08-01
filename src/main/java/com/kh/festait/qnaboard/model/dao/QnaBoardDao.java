package com.kh.festait.qnaboard.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.qnaboard.model.vo.QnaBoard;

@Mapper
public interface QnaBoardDao {
	
	void insertQna(QnaBoard qna);

    List<QnaBoard> selectAllQna(int offset, int limit);

    List<QnaBoard> selectQnaListByUser(int userNo, int offset, int limit);

    QnaBoard selectQnaById(int id);

    int countAllQna();

    int countQnaByUser(int userNo);

	void updateAnswer(int qnaId, String answerDetail);

	void deleteQna(int qnaId);

}
