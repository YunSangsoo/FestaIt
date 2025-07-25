package com.kh.spring.security.model.dao;

import com.kh.spring.users.model.vo.UsersVo;

public interface SecurityDao {
    UsersVo loadUserByUsername(String username);
}