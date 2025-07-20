package com.kh.festait.mypromo.model.service; // 패키지 이름 'service'로 변경

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 관리를 위해 추가

import com.kh.festait.mypromo.model.dao.MyPromoDao; // 'Dao'로 클래스 이름 변경
import com.kh.festait.mypromo.model.vo.MyPromoVo; // 'Vo'로 클래스 이름 변경

@Service("myPromoService") // @Service 어노테이션 추가
public class MyPromoServiceImpl implements MyPromoService { // 클래스 이름 'MyPromoServiceImpl'로 변경

    @Autowired
    private MyPromoDao myPromoDao; // 'Dao'로 필드명 변경

    // 내 홍보 게시글 목록 조회 (페이징 적용)
    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> params) { // 메서드 이름 변경
        return myPromoDao.selectMyPromoList(params);
    }

    // 특정 사용자의 전체 홍보 게시글 수 조회
    @Override
    public int selectListCount(int userNo) { // 메서드 이름 변경
        return myPromoDao.selectListCount(userNo);
    }

    // 새 홍보 게시글 삽입
    @Override
    @Transactional // 트랜잭션 관리 추가
    public int insertMyPromo(MyPromoVo promo) {
        return myPromoDao.insertMyPromo(promo);
    }

    // 홍보 게시글 상세 조회 (조회수 증가 로직 포함)
    @Override
    @Transactional // 트랜잭션 관리 추가 (조회수 증가와 게시글 조회는 한 묶음)
    public MyPromoVo selectMyPromoById(int promoNo) {
        int result = myPromoDao.increaseViews(promoNo); // 조회수 증가
        MyPromoVo promo = null;
        if (result > 0) {
            promo = myPromoDao.selectMyPromoById(promoNo); // 게시글 조회
        }
        return promo;
    }

    // 홍보 게시글 수정
    @Override
    @Transactional // 트랜잭션 관리 추가
    public int updateMyPromo(MyPromoVo promo) {
        return myPromoDao.updateMyPromo(promo);
    }

    // 홍보 게시글 삭제 (STATUS를 'N'으로 변경)
    @Override
    @Transactional // 트랜잭션 관리 추가
    public int deleteMyPromo(Map<String, Object> params) { // 파라미터 타입 변경
        return myPromoDao.deleteMyPromo(params);
    }
}