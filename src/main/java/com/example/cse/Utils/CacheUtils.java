package com.example.cse.Utils;

import com.google.gson.Gson;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

@Component
public class CacheUtils implements InitializingBean {

    @Autowired
    StringRedisTemplate redisTemplate;

    private ValueOperations<String, String> ops;

    public  void setCache(String type, String key, Object value) {
        String redisKey = type + ":" + key;
        ops.set(redisKey,new Gson().toJson(value));
    }

    public <T> T getCache(String type, String key, Class<T> typeClass) {
        String redisKey = type + ":" + key;
        String value = ops.get(redisKey);
        return new Gson().fromJson(value,typeClass);
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        ops = redisTemplate.opsForValue();
    }
}
