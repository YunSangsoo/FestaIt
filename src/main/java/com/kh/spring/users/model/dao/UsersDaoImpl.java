package com.kh.spring.users.model.dao;

import java.util.HashMap;
import java.util.List; // List 임포트 추가
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired; // Autowired 임포트 추가
import org.springframework.stereotype.Repository;

import com.kh.spring.users.model.vo.UsersVo; // UsersVo 사용

@Repository
public class UsersDaoImpl implements UsersDao {

    @Autowired
    private SqlSessionTemplate sqlSession; // SqlSessionTemplate 주입

    // 기존 메서드들 (UsersController에 있었던 메서드 이름 기준으로 재확인)
    
    @Override
    public UsersVo loginUsers(UsersVo u) {
        return sqlSession.selectOne("usersMapper.loginUsers", u);
    }

    @Override
    public int insertUsers(UsersVo u) {
        return sqlSession.insert("usersMapper.insertUsers", u);
    }

    @Override
    public int updateUsers(UsersVo u) {
        return sqlSession.update("usersMapper.updateUsers", u);
    }

    @Override
    public int idCheck(String userId) {
        return sqlSession.selectOne("usersMapper.idCheck", userId);
    }
    
    // 이 메서드는 인터페이스에 선언되어 있으나, 구체적인 매퍼 ID를 모름.
    // 만약 사용하지 않거나, 매퍼 ID를 안다면 그에 맞게 구현 필요
    @Override
    public void updateUsersChangePwd() {
        // sqlSession.update("usersMapper.updateUsersChangePwd"); // 매퍼 ID에 따라 수정
    }

    @Override
    public HashMap<String, Object> selectOne(String userId) {
        return sqlSession.selectOne("usersMapper.selectOne", userId);
    }

    // ⭐⭐ 새로 추가할 메서드 구현 ⭐⭐
    @Override
    public List<String> selectUserAuthorities(int userNo) {
        return sqlSession.selectList("usersMapper.selectUserAuthorities", userNo);
    }
}