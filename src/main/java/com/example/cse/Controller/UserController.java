package com.example.cse.Controller;

import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.UserCreate;
import com.example.cse.Vo.in.UserPass;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api(tags = "User接口", description = "除新建外需要Token验证")
@RequestMapping("/cse/User")
public class UserController {
    @Autowired
    UserServiceImpl userService;

    @PostMapping
    @ApiImplicitParam(name = "user",value = "用户注册结构体",dataTypeClass = UserCreate.class,paramType = "body")
    @ApiOperation(value = "用户注册接口",notes ="根据传入的用户基本信息创建用户，会根据规则进行检查,学号是否唯一，各属性值是否存在")
    public Vo<String> newUser(@RequestBody UserCreate user) throws NoDataException {
        Integer integer =  userService.newUser(user);
        if (integer == 1)
            return new Vo<>(Vo.Success,"用户注册成功",null);
        else
            return new Vo<>(Vo.WrongPostParameter,null,"未知错误，创建失败");
    }
}
