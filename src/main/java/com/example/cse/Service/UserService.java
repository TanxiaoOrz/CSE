package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;

public interface UserService {

    UserDto getUserByNamePass(String userCode, String password);

}
