package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.TokenService;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Vo.Vo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/cse/Token")
public class TokenController {
    @Autowired
    UserServiceImpl userService;
    @Autowired
    TokenService tokenService;

    private boolean checkEmpty(String name,String password){
        return StringUtils.hasText(name)&&StringUtils.hasText(password);
    }

    @PostMapping("/User")
    public Object login(@RequestParam String userCode,@RequestParam String password){
        if (checkEmpty(userCode,password)){
            UserDto userDto = userService.getUserByNamePass(userCode, password);
            String token = tokenService.newTokenByUser(userDto);
            return new Vo<>(Vo.Success,token);
        }else {
            return false;
        }
    }

}
