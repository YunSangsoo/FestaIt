package com.kh.spring.users.model.dao;

import java.util.HashMap;
import java.util.List;

import com.kh.spring.users.model.vo.UsersVo;

public interface UsersDao {

    UsersVo loginUsers(UsersVo u);
    List<String> selectUserAuthorities(int userNo);
    int insertUsers(UsersVo u); // ⭐ 's' 유지 ⭐
    int updateUsers(UsersVo u); // ⭐ 's' 유지 ⭐
    int idCheck(String userId);
    void updateUsersChangePwd();
    HashMap<String, Object> selectOne(String userId);
}