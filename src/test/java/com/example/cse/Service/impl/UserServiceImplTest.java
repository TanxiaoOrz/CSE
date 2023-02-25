package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.UserPass;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserServiceImplTest {

    @Autowired
    UserServiceImpl userService;

    @Test
    void getUserByNamePass() {

        UserPass userPass = new UserPass();
        userPass.setUserCode("123456");
        userPass.setUserPass("123456");
        try {
            UserDto user = userService.getUserByNamePass(userPass);
            System.out.println();
        } catch (NoDataException e) {
            System.out.println(e.getDescription());
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}