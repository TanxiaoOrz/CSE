package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@Api(tags = "User接口")
@RequestMapping("/cse/User")
@CrossOrigin
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

    @GetMapping
    @ApiOperation(value = "获取登录用户基本信息", notes = "要求进行token验证")
    public Vo<UserBasic> getUser(HttpServletRequest request) {
        return new Vo<>(Vo.Success,new UserBasic((UserDto) request.getAttribute("UserDto")),null);
    }

    @PutMapping
    @ApiOperation(value = "用户基本信息修改接口", notes = "需要经过token验证，需要正确传递uid")
    public Vo<String> updateUser(@RequestBody UserBasic user,HttpServletRequest request) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = userService.updateUser(user,userDto);
        if (integer == 1)
            return new Vo<>(Vo.Success,"用户基本信息更新成功",null);
        else
            return new Vo<>(Vo.WrongPostParameter,null,"未知错误，创建失败");
    }

    @GetMapping("/most")
    @ApiOperation(value = "获取访问最多的数据",notes = "需要经过token验证")
    public Vo<SurfMost> getUserMost(HttpServletRequest request) {
        return new Vo<>(userService.getUserSurfMost((UserDto) request.getAttribute("UserDto")));
    }

    @GetMapping("/suggest")
    @ApiOperation(value = "获得推荐模型可视化数据:关键词",notes = "需要经过token验证")
    public Vo<List<Suggest>> getUserSuggestKey(@ApiIgnore @RequestAttribute("UserDto")UserDto userDto) {
        return new Vo<>(userService.getUserSuggestKey(userDto));
    }
}
