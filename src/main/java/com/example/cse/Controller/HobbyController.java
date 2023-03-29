package com.example.cse.Controller;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Service.impl.HobbyServiceImpl;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("cse/Hobby")
@Api(tags = "爱好接口")
@CrossOrigin
public class HobbyController {
    @Autowired
    HobbyServiceImpl hobbyService;
    @Autowired
    UserServiceImpl userService;

    @PutMapping("/manager")
    @ApiOperation(value = "新建接口",notes = "需要管理员权限验证,会检测空值与同名爱好是否存在")
    @ApiImplicitParam(value = "hobby",name = "新建的爱好",dataTypeClass = HobbyIn.class, paramType = "body",required = true)
    public Vo<String> newHobby(@RequestBody HobbyIn hobby) throws NoDataException {
        Integer integer = hobbyService.newHobby(hobby);
        if (integer == 1)
            return new Vo<>(Vo.Success,"爱好创建成功",null);
        else
            return new Vo<>(Vo.WrongPostParameter,null,"未知错误，创建失败");
    }

    @GetMapping("/manager")
    @ApiOperation(value = "获取所有爱好接口",notes = "此处需要管理员验证")
    public Vo<List<HobbyDto>> getHobbyAll() {
        List<HobbyDto> hobbyAll = hobbyService.getHobbyAll();
        return new Vo<>(Vo.Success, hobbyAll, null);
    }

    @GetMapping("/User")
    @ApiOperation(value = "获取用户的爱好接口",notes = "需要用户权限验证")
    public Vo<UserHobbyOut> getUserHobby(HttpServletRequest request) {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        UserHobbyOut userHobbyOut = new UserHobbyOut();
        userHobbyOut.setInterested(HobbyOut.createHobbyOuts(hobbyService.getHobbyByUserDegree(userDto,"interested")));
        userHobbyOut.setCommon(HobbyOut.createHobbyOuts(hobbyService.getHobbyByUserDegree(userDto,"common")));
        userHobbyOut.setUninterested(HobbyOut.createHobbyOuts(hobbyService.getHobbyByUserDegree(userDto,"uninterested")));
        return new Vo<>(Vo.Success,userHobbyOut,null);
    }

    @ApiOperation(value = "用户爱好修改接口",notes = "需要用户权限验证,会检测空值与爱好是否存在")
    @ApiImplicitParam(value = "userHobbyIn",name = "要修改的爱好",dataTypeClass = UserHobbyIn.class, paramType = "body",required = true)
    @PostMapping("/User")
    public Vo<String> updateUserHobby(HttpServletRequest request, @RequestBody UserHobbyIn userHobbyIn) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = hobbyService.updateUserHobby(userHobbyIn, userDto);
        if (integer == 1){
            return new Vo<>("爱好修改成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,null,"未知错误，创建失败");
        }

    }
}
