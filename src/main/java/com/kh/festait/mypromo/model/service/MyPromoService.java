package com.kh.festait.mypromo.model.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.mypromo.model.vo.MyPromoVo;

public interface MyPromoService {

    int selectListCount(Map<String, Object> paramMap);

    List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, PageInfo pi);
}
