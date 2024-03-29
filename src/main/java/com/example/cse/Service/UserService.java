package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserService {

    UserDto getUserByNamePass(UserPass userPass) throws NoDataException;

    UserDto getUserByUid(@Param("Uid") String uid) throws NoDataException;

    Integer newUser(UserCreate userCreate) throws NoDataException;

    Integer updateUser(UserBasic newUser, UserDto oldUser) throws NoDataException;

    SurfMost getUserSurfMost(UserDto userDto);

    List<Suggest> getUserSuggestKey(UserDto userDto);

}
