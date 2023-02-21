package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.impl.CalenderServiceImpl;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.CalenderIn;
import com.example.cse.Vo.CalenderOut;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/cse/User/Calender")
@Api(tags = "代办日历接口")
public class CalenderController {
    @Autowired
    CalenderServiceImpl calenderService;
    @Autowired
    UserServiceImpl userService;

    @GetMapping
    @ApiOperation(value = "获取用户calender",notes ="需要登录")
    public Vo<CalenderOut> getUserCalender(HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        CalenderOut calenderOut = calenderService.getUserCalender(userDto);
        return new Vo<>(calenderOut);
    }

    @PutMapping
    @ApiOperation(value = "用户新增calender",notes = "需要登录")
    @ApiImplicitParam(name = "calenderIn", value = "日历结构",dataTypeClass = CalenderIn.class,paramType = "body")
    public Vo<String> newUserCalender(HttpServletRequest request, @RequestBody CalenderIn calenderIn) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = calenderService.newUserCalender(userDto,calenderIn);
        if (integer == 1){
            userService.calculateUserModel(userDto);
            return new Vo<>("新增成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,"未知错误，创建失败");
        }
    }

    @DeleteMapping()
    @ApiOperation(value = "用户删除calender",notes = "需要登录")
    @ApiImplicitParam(name = "calenderIn", value = "日历结构",dataTypeClass = CalenderIn.class,paramType = "body")
    public Vo<String> deleteUserCalender(HttpServletRequest request, @RequestBody CalenderIn calenderIn) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = calenderService.deleteUserCalender(userDto, calenderIn);
        if (integer == 1){
            userService.calculateUserModel(userDto);
            return new Vo<>("删除成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,"未知错误，删除失败");
        }
    }

    @PostMapping
    @ApiOperation(value = "用户修改calender",notes = "需要登录")
    @ApiImplicitParam(name = "calenderIn", value = "日历结构",dataTypeClass = CalenderIn.class,paramType = "body")
    public Vo<String> updateUserCalender(HttpServletRequest request, @RequestBody CalenderIn calenderIn) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = calenderService.updateUserCalender(userDto,calenderIn);
        if (integer == 1){
            return new Vo<>("新增成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,"未知错误，创建失败");
        }
    }
}
