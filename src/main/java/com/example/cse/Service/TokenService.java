package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;

public interface TokenService {

    String newTokenByUser(UserDto user);

    UserDto getUserByToken(String token);



}
