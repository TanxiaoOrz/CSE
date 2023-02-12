package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface UserMapper {

    List<User> findAll();

    User getUserByNamePass(@Param("name") String name,@Param("pass") String pass);

}
