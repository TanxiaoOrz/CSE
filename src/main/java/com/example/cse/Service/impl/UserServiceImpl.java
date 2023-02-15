package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.ProfessionMapper;
import com.example.cse.Mapper.UserMapper;
import com.example.cse.Service.UserService;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.UserCreate;
import com.example.cse.Vo.in.UserPass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;
    @Autowired
    ProfessionMapper professionMapper;

    @Override
    public UserDto getUserByNamePass(UserPass userPass) throws NoDataException{
        userPass.checkNull();
        User user = userMapper.getUserByNamePass(userPass);
        if (user == null) {
            return null;
        }
        return new UserDto(user);
    }

    @Override
    public Integer newUser(UserCreate userCreate) throws NoDataException {
        userCreate.checkNull(professionMapper,userMapper);
        userMapper.newUser(userCreate);
        return userMapper.newUser(userCreate);
    }
}
