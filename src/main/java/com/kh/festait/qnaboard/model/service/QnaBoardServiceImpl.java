package com.kh.festait.qnaboard.model.service;

import com.kh.festait.qnaboard.model.dao.QnaBoardDao;
import com.kh.festait.qnaboard.model.vo.QnaBoard;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QnaBoardServiceImpl implements QnaBoardService{

	private static final int PAGE_SIZE = 10;  // 페이지 당 게시물 수

    @Autowired
    private QnaBoardDao qnaBoardDao;

    @Override
    public void insertQna(QnaBoard qna) {
        qnaBoardDao.insertQna(qna);
    }

    @Override
    public List<QnaBoard> selectQnaList(String viewMode, int userNo, int page) {
        int offset = (page - 1) * PAGE_SIZE;
        List<QnaBoard> list;

        if ("mine".equals(viewMode)) {
            list = qnaBoardDao.selectQnaListByUser(userNo, offset, PAGE_SIZE);
        } else {
            list = qnaBoardDao.selectAllQna(offset, PAGE_SIZE);
        }

        for (QnaBoard qna : list) {
            qna.setAnswered(qna.getAnswerDetail() != null && !qna.getAnswerDetail().trim().isEmpty());
        }

        return list;
    }

    @Override
    public QnaBoard selectQnaById(int id) {
        return qnaBoardDao.selectQnaById(id);
    }

    @Override
    public int getTotalPage(String viewMode, int userNo) {
        int totalCount = "mine".equals(viewMode)
                ? qnaBoardDao.countQnaByUser(userNo)
                : qnaBoardDao.countAllQna();

        return (int) Math.ceil((double) totalCount / PAGE_SIZE);
    }

	@Override
	public void updateAnswer(int qnaId, String answerDetail) {
		qnaBoardDao.updateAnswer(qnaId, answerDetail);
		
	}
    
    
	
}
