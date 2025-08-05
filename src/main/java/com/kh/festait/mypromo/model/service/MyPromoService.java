package com.kh.festait.mypromo.model.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.mypromo.model.vo.MyPromoVo;

public interface MyPromoService {

    // 내 홍보 게시글 전체 수 조회 (검색 조건 포함)
    int selectListCount(Map<String, Object> paramMap);

    // 내 홍보 게시글 목록 조회 (페이징 및 검색 조건 포함)
    List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, PageInfo pi);
}
