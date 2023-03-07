package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.ManagerService;
import com.example.cse.Service.impl.ManagerServiceImpl;
import com.example.cse.Service.impl.TokenServiceImpl;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.UserPass;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@Api(tags = "Token接口",description = "Token的获取与注销接口,该接口不需要token验证")
@RequestMapping("/cse/Token")
@CrossOrigin
public class TokenController {
    @Autowired
    UserServiceImpl userService;
    @Autowired
    TokenServiceImpl tokenService;
    @Autowired
    ManagerServiceImpl managerService;



    @ApiOperation(value = "用户申请token接口", notes = "根据传入的用户信息获取token，并在redis中进行缓存")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userPass", value = "用户登录结构体", dataTypeClass = UserPass.class, paramType = "body", required = true),
    })
    @CrossOrigin(methods = RequestMethod.POST)
    @PostMapping("/User")
    public Vo<String> loginUser(@RequestBody UserPass userPass) throws NoDataException{
        UserDto userDto = userService.getUserByNamePass(userPass);
        if (userDto != null) {
            String token = tokenService.newTokenByUser(userDto);
            return new Vo<>(Vo.Success,token,null);
        }else {
            return new Vo<>(Vo.WrongPostParameter,null, "用户学号或密码错误");
        }
    }

    @ApiOperation(value = "管理员申请token接口", notes = "根据传入的用户信息获取token")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userPass", value = "用户登录结构体", dataTypeClass = UserPass.class, paramType = "body", required = true),
    })
    @CrossOrigin(methods = RequestMethod.POST)
    @PostMapping("/Manager")
    public Vo<String> loginManager(@RequestBody UserPass userPass, HttpServletRequest request) throws NoDataException{
        if (managerService.checkManager(userPass)) {
            String token = tokenService.newTokenByManager(request);
            return new Vo<>(Vo.Success,token,null);
        }else {
            return new Vo<>(Vo.WrongPostParameter,null, "管理员编号或密码错误");
        }
    }


}
