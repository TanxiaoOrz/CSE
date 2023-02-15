package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.UserCreate;
import com.example.cse.Vo.in.UserPass;

public interface UserService {

    UserDto getUserByNamePass(UserPass userPass) throws NoDataException;

    Integer newUser(UserCreate userCreate) throws NoDataException;

}
