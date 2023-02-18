package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.HobbyMapper;
import com.example.cse.Mapper.ProfessionMapper;
import com.example.cse.Mapper.UserMapper;
import com.example.cse.Service.UserService;
import com.example.cse.Utils.CacheUtils;
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
    @Autowired
    HobbyMapper hobbyMapper;
    @Autowired
    CacheUtils cacheUtils;


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
    public UserDto getUserByUid(String uid) throws NoDataException {
        if (StringUtils.hasText(uid)) {
            User user = userMapper.getUserByUid(uid);
            if (user == null) {
                throw new NoDataException(Vo.WrongPostParameter,"token包含未知Uid");
            }
            UserDto userDto = new UserDto(user, professionMapper);
            cacheUtils.setCache("User",uid,userDto);
            return userDto;
        }
        throw new NoDataException(Vo.WrongPostParameter,"token没有Uid");
    }

    @Override
    public Integer newUser(UserCreate userCreate) throws NoDataException {
        userCreate.checkNull(professionMapper,userMapper);
        if (userMapper.checkUserExist(userCreate.getUserCode())==0) {
            userMapper.newUser(userCreate);
            return userMapper.newUser(userCreate);
        }else
            throw new NoDataException(Vo.WrongPostParameter,"该学号已存在");
    }

    @Override
    public Integer updateUser(UserBasic newUser, UserDto oldUser) throws NoDataException{
        User user = new User();
        boolean empty = false;
        if (newUser.getUid().equals(oldUser.getUid()))
            user.setUid(newUser.getUid());
        else
            throw new NoDataException(Vo.WrongPostParameter,"修改的Uid与登录Uid不一致");
        if (StringUtils.hasText(newUser.getUserName())&&!Objects.equals(newUser.getUserName(), oldUser.getUserName())){
            user.setUserName(newUser.getUserName());
            oldUser.setUserName(newUser.getUserName());
            empty = true;
        }
        if (StringUtils.hasText(newUser.getSex())&&!Objects.equals(newUser.getSex(), oldUser.getSex())){
            user.setSex(newUser.getSex());
            oldUser.setSex(newUser.getSex());
            empty = true;
        }
        if (newUser.getProfession()!=null&&!Objects.equals(newUser.getProfession(), oldUser.getProfession().getPid())){
            user.setProfession(newUser.getProfession());
            Profession profession = professionMapper.getProfessionByPid(newUser.getProfession());
            if (profession == null) {
                throw new NoDataException(Vo.WrongPostParameter,"错误的专业序号");
            }
            oldUser.setProfession(profession);
            empty = true;
        }
        if (StringUtils.hasText(newUser.getGrade())&&!Objects.equals(newUser.getGrade(), oldUser.getGrade())){
            user.setGrade(newUser.getGrade());
            oldUser.setGrade(newUser.getGrade());
            empty = true;
        }
        if (!empty)
            throw new NoDataException(Vo.WrongPostParameter,"没有进行更改");
        Integer integer =userMapper.updateUser(user);
        cacheUtils.setCache("User",oldUser.getUid().toString(),oldUser);

        return integer;
    }

    @Override
    public void calculateUserModel(UserDto userDto) {

    }


}
