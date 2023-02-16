package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.ProfessionMapper;
import com.example.cse.Mapper.UserMapper;
import com.example.cse.Service.UserService;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.UserBasic;
import com.example.cse.Vo.UserCreate;
import com.example.cse.Vo.UserPass;
import com.example.cse.Vo.Vo;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Objects;


@Service
public class UserServiceImpl implements UserService{

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
        return new UserDto(user,professionMapper);
    }

    @Override
    public Integer newUser(UserCreate userCreate) throws NoDataException {
        userCreate.checkNull(professionMapper,userMapper);
        userMapper.newUser(userCreate);
        return userMapper.newUser(userCreate);
    }

    @Override
    public Integer updateUser(UserBasic newUser, UserDto oldUser) throws NoDataException{
        User user = new User();
        boolean empty = false;
        if (StringUtils.hasText(newUser.getUserName())&&!Objects.equals(newUser.getUserName(), oldUser.getName())){
            user.setName(newUser.getUserName());
            empty = true;
        }
        if (StringUtils.hasText(newUser.getSex())&&!Objects.equals(newUser.getSex(), oldUser.getSex())){
            user.setSex(newUser.getSex());
            empty = true;
        }
        if (newUser.getProfession()!=null&&!Objects.equals(newUser.getProfession(), oldUser.getProfession().getPid())){
            user.setName(newUser.getUserName());
            empty = true;
        }
        if (StringUtils.hasText(newUser.getGrade())&&!Objects.equals(newUser.getUserName(), oldUser.getGrade())){
            user.setGrade(newUser.getGrade());
            empty = true;
        }
        if (!empty)
            throw new NoDataException(Vo.WrongPostParameter,"没有进行更改");
        return userMapper.updateUser(user);
    }


}
