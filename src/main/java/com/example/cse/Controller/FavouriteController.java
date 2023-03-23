package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.impl.FavouriteServiceImpl;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.FavouriteOut;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/cse/User/Favourite")
@Api(tags = "用户的favourite接口")
public class FavouriteController {

    @Autowired
    FavouriteServiceImpl favouriteService;
    @Autowired
    UserServiceImpl userService;

    @GetMapping
    @ApiOperation(value = "获取用户favourite",notes ="需要登录")
    public Vo<FavouriteOut> getUserFavourite(HttpServletRequest request){
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        FavouriteOut favourite = favouriteService.getFavouriteByUser(userDto);
        return new Vo<>(favourite);
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "用户新增喜欢",notes = "需要登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应喜欢的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "type",value = "喜欢的类型,限定message，location，informationClass",dataTypeClass = String.class,paramType = "query")
    })
    public Vo<String> newUserFavourite(HttpServletRequest request, @PathVariable Integer id,@RequestParam String type) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = favouriteService.newFavourite(userDto, id, type);
        if (integer == 1){
            userService.calculateUserModel(userDto);
            return new Vo<>("新增成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,"未知错误，创建失败");
        }
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "用户删除喜欢",notes = "需要登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应喜欢的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "type",value = "喜欢的类型,限定message，location，informationClass",dataTypeClass = String.class,paramType = "query")
    })
    public Vo<String> deleteUserFavourite(HttpServletRequest request, @PathVariable Integer id,@RequestParam String type) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = favouriteService.deleteFavourite(userDto, id, type);
        if (integer == 1){
            return new Vo<>("删除成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,"未知错误，删除失败");
        }
    }

    @DeleteMapping("/null")
    @ApiOperation(value = "用户删除喜欢",notes = "需要登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type",value = "喜欢的类型,限定message，location，informationClass",dataTypeClass = String.class,paramType = "query")
    })
    public Vo<String> deleteUserFavouriteNUll(HttpServletRequest request,@RequestParam String type) throws NoDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        Integer integer = favouriteService.deleteFavouriteNull(userDto, type);
        if (integer != 0){
            return new Vo<>("删除成功");
        }else {
            return new Vo<>(Vo.WrongPostParameter,"未知错误，删除失败");
        }
    }
}
