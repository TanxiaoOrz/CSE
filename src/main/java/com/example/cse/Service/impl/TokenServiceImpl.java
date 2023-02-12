package com.example.cse.Service.impl;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.example.cse.Dto.UserDto;
import com.example.cse.Service.TokenService;
import com.google.gson.Gson;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.util.Calendar;


@Service
public class TokenServiceImpl implements TokenService, InitializingBean {


    @Autowired
    StringRedisTemplate stringRedisTemplate;

    @Value("${config.token-pass}")
    String tokenPass;

    private ValueOperations<String, String> ops;

    @Value("${spring.redis.timeout}")
    int tokenOutSecond;

    @Override
    public String newTokenByUser(UserDto user) {
        Calendar instance = Calendar.getInstance();
        instance.add(Calendar.SECOND,tokenOutSecond);

        String token = JWT.create()
                .withClaim(user.getName(),user.getUid())
                .withExpiresAt(instance.getTime())
                .sign(Algorithm.HMAC256(tokenPass));

        ops.set(token, new Gson().toJson(user));

        return token;
    }

    @Override
    public UserDto getUserByToken(String token) {
        return new Gson().fromJson(ops.get(token),UserDto.class);
    }

    @Override
    public void afterPropertiesSet(){
        ops = stringRedisTemplate.opsForValue();
    }
}
