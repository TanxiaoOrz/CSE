package com.example.cse.Mapper;

import com.example.cse.Entity.Recommend.Hobby;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface HobbyMapper {

    Integer newHobby(Hobby hobby);

    Hobby getHobbyByRule(Hobby hobby);

    List<Hobby> getHobbyAll();

    List<Hobby> getHobbyByUserDegree(@Param("Uid") Integer uid, @Param("degree") String degree);

    Integer updateUserHobby(@Param("Uid") Integer uid, @Param("Hid") Integer Hid, @Param("degree") String degree);

}
