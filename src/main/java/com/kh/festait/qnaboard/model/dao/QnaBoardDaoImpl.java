package com.kh.festait.qnaboard.model.dao;

import com.kh.festait.qnaboard.model.vo.QnaBoard;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class QnaBoardDaoImpl implements QnaBoardDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "qnaBoardMapper.";

    @Override
    public void insertQna(QnaBoard qna) {
        sqlSession.insert(NAMESPACE + "insertQna", qna);
    }

    @Override
    public List<QnaBoard> selectAllQna(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList(NAMESPACE + "selectAllQna", params);
    }

    @Override
    public List<QnaBoard> selectQnaListByUser(int userNo, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("userNo", userNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList(NAMESPACE + "selectQnaListByUser", params);
    }

    @Override
    public QnaBoard selectQnaById(int id) {
        return sqlSession.selectOne(NAMESPACE + "selectQnaById", id);
    }

    @Override
    public int countAllQna() {
        return sqlSession.selectOne(NAMESPACE + "countAllQna");
    }

    @Override
    public int countQnaByUser(int userNo) {
        return sqlSession.selectOne(NAMESPACE + "countQnaByUser", userNo);
    }

	@Override
	public void updateAnswer(int qnaId, String answerDetail) {
		Map<String, Object> params = new HashMap<>();
	    params.put("qnaId", qnaId);
	    params.put("answerDetail", answerDetail);
	    sqlSession.update(NAMESPACE + "updateAnswer", params);
		
	}

	@Override
	public void deleteQna(int qnaId) {
	    sqlSession.delete(NAMESPACE + "deleteQna", qnaId);
	}
    
}