package com.example.cse.Controller;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.LocationServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.LocationIn;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/cse/Location")
@Api(tags = "Location接口")
@CrossOrigin
public class LocationController {
    @Autowired
    LocationServiceImpl locationService;

    @Autowired
    SurfServiceImpl surfService;

    @GetMapping({"/User/{id}","/{id}"})
    @ApiOperation(value = "获取Location接口",notes = "获取Location的展示结构体,需要传入id,token会做检测，无token也可")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应Location的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "informationLimit",value = "需要详细展示的informationCLass数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "messageLimit",value = "需要详细展示的message数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "informationMessageLimit",value = "需要详细展示的informationClass中message数量",dataTypeClass = Integer.class,paramType = "query")

    })
    public Vo<LocationDto> getLocation(@PathVariable Integer id, @RequestParam(required = false)Integer informationLimit, @RequestParam(required = false)Integer messageLimit, @RequestParam(required = false)Integer informationMessageLimit, HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        LocationDto locationDto = locationService.getLocation(id,userDto,informationLimit,messageLimit,informationMessageLimit);

            surfService.newSurf(userDto,id, SurfService.LOCATION);

        return new Vo<>(locationDto);
    }

    @GetMapping("/User")
    @ApiOperation(value = "获取多个location接口", notes = "供首页和地点列表使用,token会做检测，无token也可," +
            "\n四个limit同时有代表获取展示的个数，同时没有代表获取所有")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "locationLimit",value = "地点的数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "informationLimit",value = "地点中展示信息类的数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "messageLimit",value = "地点中展示的信息数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "informationMessageLimit",value = "地点中信息类中展示的信息数量",dataTypeClass = Integer.class,paramType = "query")
    })
    public Vo<List<LocationDto>> getLocations(@RequestParam Integer informationLimit,
                                                      @RequestParam Integer messageLimit,
                                                      @RequestParam Integer informationMessageLimit,
                                                      @RequestParam Integer locationLimit,
                                                      HttpServletRequest request){
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        List<LocationDto> returns;

        returns = locationService.getLocationsShow(userDto,locationLimit,informationLimit,messageLimit,informationMessageLimit);

        return new Vo<>(returns);
    }

    @GetMapping()
    @ApiOperation(value = "获取全部location接口",notes = "获取location的展示结构体,如果有搜索字符串按字符串规则筛选")
    @ApiImplicitParam(name = "search", value = "搜索字符串",dataTypeClass = String.class,paramType = "query")
    public Vo<List<LocationDto>> searchMessages(@RequestParam(required = false) String search) {
        List<LocationDto> locationDtos = locationService.searchLocations(search);
        return new Vo<>(locationDtos);
    }

    @PostMapping("/Manager")
    @ApiOperation(value = "管理员新建location",notes = "传入location结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "location",value = "要新建的location信息结构体",dataTypeClass = LocationIn.class,paramType = "body")
    public Vo<String> newInformation(@RequestBody LocationIn location) {
        Integer integer = locationService.newLocation(location);
        if (integer==1)
            return new Vo<>("新建成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @PutMapping("/Manager")
    @ApiOperation(value = "管理员修改location",notes = "传入informationClass结构体,需要传入id,需要管理员权限")
    @ApiImplicitParam(name = "location",value = "要修改的informationClass信息结构体,此处一定要修改编号",dataTypeClass = LocationIn.class,paramType = "body")
    public Vo<String> updateInformation(@RequestBody LocationIn location) throws WrongDataException {
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
    @ApiOperation(value = "管理员删除location",notes = "传入location结构体,需要传入id,需要管理员权限")
    @ApiImplicitParam(name = "id",value = "要删除的location编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<String> deleteInformation(@PathVariable Integer id) {
        Integer integer = locationService.deleteLocation(id);
        if (integer==1)
            return new Vo<>("删除成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知编号");
    }
}
