package com.example.cse.Service;

import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.cse.Dto.UserDto;

import javax.servlet.http.HttpServletRequest;

public interface TokenService {

    String newTokenByUser(UserDto user);

    String newTokenByManager(HttpServletRequest request);

    UserDto getUserByToken(DecodedJWT decodedJWT);

    DecodedJWT verifyToken(String token);

    boolean checkTokenType(DecodedJWT decodedJWT, int Type);

}
