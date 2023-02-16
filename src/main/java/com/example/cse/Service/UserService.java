package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.UserBasic;
import com.example.cse.Vo.UserCreate;
import com.example.cse.Vo.UserPass;

public interface UserService {

    UserDto getUserByNamePass(UserPass userPass) throws NoDataException;

    Integer newUser(UserCreate userCreate) throws NoDataException;

    Integer updateUser(UserBasic newUser, UserDto oldUser) throws NoDataException;

}
