package com.kh.festait.mypromo.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.mypromo.model.dao.MyPromoDao; // MyPromoDao 인터페이스 임포트
import com.kh.festait.mypromo.model.vo.MyPromoVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPromoServiceImpl implements MyPromoService {

    private final MyPromoDao myPromoDao; // MyPromoDao 인터페이스 주입

    @Override
    public int selectListCount(Map<String, Object> paramMap) {
        return myPromoDao.selectListCount(paramMap);
    }

    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, PageInfo pi) {
        // RowBounds 객체 생성 (offset, limit)
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
        return myPromoDao.selectMyPromoList(paramMap, rowBounds);
    }

}
