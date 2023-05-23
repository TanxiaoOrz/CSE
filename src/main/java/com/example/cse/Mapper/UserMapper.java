package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.User;
import com.example.cse.Vo.UserPass;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserMapper {

    @Select("SELECT Uid from user_hobby where Hid = #{Hid} and degree = #{degree}")
    List<Integer> getUidsByHobby(@Param("Hid") Integer hid, @Param("degree") String degree);

    @Select("SELECT Uid from user where Profession = #{Pid}")
    List<Integer> getUidsByPid(@Param("Pid") Integer pid);

    @Select("select Uid from user where Grade = #{Grade}")
    List<Integer> getUidsByYear(@Param("Grade") String grade);

    User getUserByNamePass(UserPass userPass);

    User getUserByUid(@Param("Uid") String uid);

    Integer newUser(User user);

    Integer checkUserExist(@Param("userCode") String userCode);

    Integer updateUser(User user);

}
