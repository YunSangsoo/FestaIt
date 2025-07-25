package com.kh.spring.users.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.users.model.dao.UsersDao;
import com.kh.spring.users.model.vo.UsersVo;

@Service
public class UsersServiceImpl implements UsersService {

    @Autowired
    private UsersDao uDao;

    @Override
    public UsersVo loginUsers(UsersVo u) {
        UsersVo loginUser = uDao.loginUsers(u);

        if (loginUser != null) {
            List<String> authorities = uDao.selectUserAuthorities(loginUser.getUserNo());
            loginUser.setAuthorities(authorities);
        }
        return loginUser;
    }

    @Override
    public int insertUsers(UsersVo u) { // ⭐ 's' 유지 ⭐
        return uDao.insertUsers(u); // ⭐ 's' 유지 ⭐
    }

    @Override
    public int updateUsers(UsersVo u) { // ⭐ 's' 유지 ⭐
        return uDao.updateUsers(u); // ⭐ 's' 유지 ⭐
    }

    @Override
    public int idCheck(String userId) {
        return uDao.idCheck(userId);
    }

    @Override
    public void updateUsersChangePwd() {
        uDao.updateUsersChangePwd();
    }

    @Override
    public HashMap<String, Object> selectOne(String userId) {
        return uDao.selectOne(userId);
    }
}