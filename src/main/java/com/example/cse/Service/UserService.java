package com.example.cse.Service;

import com.example.cse.Dto.SurfCounts;
import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.SurfMost;
import com.example.cse.Vo.UserBasic;
import com.example.cse.Vo.UserCreate;
import com.example.cse.Vo.UserPass;
import org.apache.ibatis.annotations.Param;

public interface UserService {

    UserDto getUserByNamePass(UserPass userPass) throws NoDataException;

    UserDto getUserByUid(@Param("Uid") String uid) throws NoDataException;

    Integer newUser(UserCreate userCreate) throws NoDataException;

    Integer updateUser(UserBasic newUser, UserDto oldUser) throws NoDataException;

    void calculateUserModel(UserDto userDto);

    SurfMost getUserSurfMost(UserDto userDto);

}
