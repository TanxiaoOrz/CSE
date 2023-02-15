package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.User;
import com.example.cse.Vo.in.UserCreate;
import com.example.cse.Vo.in.UserPass;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    List<User> findAll();

    User getUserByNamePass(UserPass userPass);

    Integer newUser(UserCreate userCreate);

    Integer checkUserExist(@Param("userCode") String userCode);

}
