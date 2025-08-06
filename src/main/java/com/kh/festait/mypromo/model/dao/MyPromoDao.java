package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

public interface MyPromoDao {

    //  게시글 전체 수 조회
    int selectListCount(Map<String, Object> paramMap);

    // 게시글 목록 조회
    List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, RowBounds rowBounds);

}
