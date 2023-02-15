package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.TokenService;
import com.example.cse.Service.impl.TokenServiceImpl;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.UserPass;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@Api("Token的获取与注销接口,该接口不需要token验证")
@RequestMapping("/cse/Token")
public class TokenController {
    @Autowired
    UserServiceImpl userService;
    @Autowired
    TokenServiceImpl tokenService;



    @ApiOperation(value = "用户token接口", notes = "根据传入的用户信息获取token，并在redis中进行缓存")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userPass", value = "用户登录结构体", dataTypeClass = UserPass.class, paramType = "body", required = true),
    })
    @PostMapping("/User")
    //@RequestBody UserPass
    public Vo<String> login(@RequestBody UserPass userPass) throws NoDataException{
        UserDto userDto = userService.getUserByNamePass(userPass);
        if (userDto != null) {
            String token = tokenService.newTokenByUser(userDto);
            return new Vo<>(Vo.Success,token,null);
        }else {
            return new Vo<>(Vo.WrongPostParameter,null, "用户学号或密码错误");
        }
    }

}
