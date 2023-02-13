package com.example.cse.Service;

import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;

public interface TokenService {

    String newTokenByUser(UserDto user);

    UserDto getUserByToken(DecodedJWT decodedJWT);

    DecodedJWT verifyToken(String token);

    boolean checkTokenType(DecodedJWT decodedJWT, int Type);

}
