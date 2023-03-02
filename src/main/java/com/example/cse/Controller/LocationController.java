package com.example.cse.Controller;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.LocationServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/cse/Location")
@Api(tags = "Location接口")
public class LocationController {
    @Autowired
    LocationServiceImpl locationService;

    @Autowired
    SurfServiceImpl surfService;

    @GetMapping("/User/{id}")
    @ApiOperation(value = "普通用户的获取Location接口",notes = "获取Location的展示结构体,需要传入id,token会做检测，无token也可")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应Location的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "informationLimit",value = "需要详细展示的informationCLass数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "messageLimit",value = "需要详细展示的message数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "informationMessageLimit",value = "需要详细展示的informationClass中message数量",dataTypeClass = Integer.class,paramType = "query")

    })
    public Vo<LocationDto> getMessage(@PathVariable Integer id, @RequestParam(required = false)Integer informationLimit, @RequestParam(required = false)Integer messageLimit, @RequestParam(required = false)Integer informationMessageLimit, HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        LocationDto locationDto = locationService.getLocation(id,userDto,informationLimit,messageLimit,informationMessageLimit);
        if (userDto != null) {
            surfService.newSurf(userDto,id, SurfService.LOCATION);
        }
        return new Vo<>(locationDto);
    }
}
