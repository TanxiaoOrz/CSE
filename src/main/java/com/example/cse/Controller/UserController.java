package com.example.cse.Controller;

import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.UserCreate;
import com.example.cse.Vo.in.UserPass;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api(tags = "User资源的接口，符合Restful风格,除特定接口外需要Token验证")
@RequestMapping("/cse/User")
public class UserController {
    @Autowired
    UserServiceImpl userService;

    @PostMapping
    public Vo<String> newUser(@RequestBody UserCreate user) throws NoDataException {
        Integer integer =  userService.newUser(user);
        if (integer == 1)
            return new Vo<>(Vo.Success,"用户注册成功",null);
        else
            return new Vo<>(Vo.WrongPostParameter,null,"未知错误，创建失败");
    }
}
