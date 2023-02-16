package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.User;
import com.example.cse.Vo.UserCreate;
import com.example.cse.Vo.UserPass;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    List<User> findAll();

    User getUserByNamePass(UserPass userPass);

    Integer newUser(UserCreate userCreate);

    Integer checkUserExist(@Param("userCode") String userCode);

    Integer updateUser(User user);

}
