package com.kh.festait.mypromo.model.service; 

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 관리를 위해 추가

import com.kh.festait.mypromo.model.dao.MyPromoDao; // 'Dao'로 클래스 이름 변경
import com.kh.festait.mypromo.model.vo.MyPromoVo; // 'Vo'로 클래스 이름 변경

@Service("myPromoService") // @Service 어노테이션 추가
public class MyPromoServiceImpl implements MyPromoService { 

    @Autowired
    private MyPromoDao myPromoDao; 

    // 내 홍보 게시글 목록 조회 (페이징 적용)
    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> params) { 
        return myPromoDao.selectMyPromoList(params);
    }

    // 특정 사용자의 전체 홍보 게시글 수 조회
    @Override
    public int selectListCount(int userNo) {
        return myPromoDao.selectListCount(userNo);
    }


}
