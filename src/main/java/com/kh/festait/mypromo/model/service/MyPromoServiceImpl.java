package com.kh.festait.mypromo.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.mypromo.model.dao.MyPromoDao;
import com.kh.festait.mypromo.model.vo.MyPromoVo;

@Service
public class MyPromoServiceImpl implements MyPromoService {

    @Autowired
    private MyPromoDao promoDao;

    // 로그인 사용자의 게시글 총 개수 조회
    @Override
    public int selectListCount(Map<String, Object> paramMap) {
        return promoDao.selectListCount(paramMap);
    }

    // 로그인 사용자의 게시글 목록 조회 (페이징 포함)
    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return promoDao.selectMyPromoList(paramMap, rowBounds);
    }
}
