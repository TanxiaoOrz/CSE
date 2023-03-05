package com.example.cse.Controller;

import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
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

    @PostMapping("/Manager")
    @ApiOperation(value = "管理员新建location",notes = "传入location结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "location",value = "要新建的location信息结构体",dataTypeClass = Location.class,paramType = "body")
    public Vo<String> newInformation(@RequestBody Location location) {
        Integer integer = locationService.newLocation(location);
        if (integer==1)
            return new Vo<>("新建成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @PutMapping("/Manager")
    @ApiOperation(value = "管理员新建location",notes = "传入informationClass结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "location",value = "要修改的informationClass信息结构体,此处一定要修改编号",dataTypeClass = Location.class,paramType = "body")
    public Vo<String> updateInformation(@RequestBody Location location) throws WrongDataException {
        if (location.getLid() == null) {
            return new Vo<>(Vo.WrongPostParameter,"请输入要修改的编号");
        }
        Integer integer = locationService.updateLocation(location);
        if (integer==1)
            return new Vo<>("修改成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @DeleteMapping("/Manager/{id}")
    @ApiOperation(value = "管理员新建location",notes = "传入location结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "location",value = "要删除的location编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<String> deleteInformation(@PathVariable Integer id) {
        Integer integer = locationService.deleteLocation(id);
        if (integer==1)
            return new Vo<>("删除成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }
}
