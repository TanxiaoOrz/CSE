package com.example.cse.Service.impl;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.cse.Dto.UserDto;
import com.example.cse.Mapper.UserMapper;
import com.example.cse.Service.TokenService;
import com.example.cse.Utils.CacheUtils;
import com.google.gson.Gson;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import java.util.Calendar;


@Service
public class TokenServiceImpl implements TokenService{

    public final static int UserType = 0;
    public final static int ManagerType = 1;
    private Algorithm algorithm;

    @Autowired
    CacheUtils cacheUtils;

    @Autowired
    UserMapper userMapper;

    @Value("${config.token-pass}")
    String tokenPass;

    @Value("${spring.redis.timeout}")
    int tokenOutSecond;

    @Override
    public String newTokenByUser(UserDto user) {
        Calendar instance = Calendar.getInstance();
        instance.add(Calendar.SECOND,tokenOutSecond);

        String token = JWT.create()
                .withClaim("type",UserType)
                .withClaim("Uid",user.getUid())
                .withExpiresAt(instance.getTime())
                .sign(algorithm);

        cacheUtils.setCache("User",user.getUid().toString(),user);

        return token;
    }

    @Override
    public DecodedJWT verifyToken(String token) {
        return JWT.require(algorithm).build().verify(token);
    }

    @Override
    public boolean checkTokenType(DecodedJWT decodedJWT, int type) {
        Claim claim = decodedJWT.getClaim("type");
        return type == claim.asInt() ;
    }

    @Override
    public UserDto getUserByToken(DecodedJWT decodedJWT) {
        String Uid = decodedJWT.getClaim("Uid").asString();
        return cacheUtils.getCache("User",Uid,UserDto.class);
    }

}
