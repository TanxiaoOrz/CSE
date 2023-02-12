package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.UserMapper;
import com.example.cse.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public UserDto getUserByNamePass(String name, String password) {
        User user = userMapper.getUserByNamePass(name, password);
        return new UserDto(user);
    }

}
