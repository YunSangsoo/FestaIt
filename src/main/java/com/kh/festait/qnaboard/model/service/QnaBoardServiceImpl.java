package com.kh.festait.qnaboard.model.service;

import com.kh.festait.qnaboard.model.dao.QnaBoardDao;
import com.kh.festait.qnaboard.model.vo.QnaBoard;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QnaBoardServiceImpl implements QnaBoardService {

    private static final int PAGE_SIZE = 10;  // 페이지 당 게시물 수

    private final QnaBoardDao qnaBoardDao;

    @Override
    public void insertQna(QnaBoard qna) {
        qnaBoardDao.insertQna(qna);
    }

    @Override
    public List<QnaBoard> selectQnaList(String viewMode, int userNo, int page, int limit) {
        int offset = (page - 1) * limit;
        List<QnaBoard> list;

        if ("mine".equals(viewMode)) {
            list = qnaBoardDao.selectQnaListByUser(userNo, offset, limit);
        } else {
            list = qnaBoardDao.selectAllQna(offset, limit);
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
        int totalCount = getTotalCount(viewMode, userNo);
        return (int) Math.ceil((double) totalCount / PAGE_SIZE);
    }

    @Override
    public int getTotalCount(String viewMode, int userNo) {
        if ("mine".equals(viewMode)) {
            return qnaBoardDao.countQnaByUser(userNo);
        } else {
            return qnaBoardDao.countAllQna();
        }
    }

    @Override
    public void updateAnswer(int qnaId, String answerDetail) {
        qnaBoardDao.updateAnswer(qnaId, answerDetail);
    }

    @Override
    public void deleteQna(int qnaId) {
        qnaBoardDao.deleteQna(qnaId);
    }
}
    
    
