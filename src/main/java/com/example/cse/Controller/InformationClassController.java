package com.example.cse.Controller;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Service.InformationClassService;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.InformationClassServiceImpl;
import com.example.cse.Service.impl.MessageServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.InformationClassIn;
import com.example.cse.Vo.MessageIn;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/cse/InformationClass")
@Api(tags = "informationClass接口")
public class InformationClassController {
    @Autowired
    InformationClassServiceImpl informationClassService;
    @Autowired
    SurfServiceImpl surfService;

    @GetMapping("/User")
    @ApiOperation(value = "普通用户获取多个informationClass接口", notes = "供首页和分类信息使用,token会做检测，无token也可," +
            "\n两个limit同时有代表获取展示的个数，同时没有代表获取所有")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "classLimit",value = "信息类的数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "messageLimit",value = "信息类中展示的信息数量",dataTypeClass = Integer.class,paramType = "query"),
            @ApiImplicitParam(name = "type",value = "信息类中类型要求",dataTypeClass = String.class,paramType = "query")
    })
    public Vo<List<InformationClassDto>> getInformationClasses(@RequestParam(required = false) Integer classLimit,
                                                            @RequestParam(required = false) Integer messageLimit,
                                                            @RequestParam(required = false) String type,
                                                            HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        List<InformationClassDto> returns;
        if (classLimit==null&&messageLimit==null) {
            returns = informationClassService.getInformationClassesAll(userDto,type);
        }else if (classLimit!=null&&messageLimit!=null){
            returns = informationClassService.getInformationClassesShow(userDto,classLimit,messageLimit,type);
        }else
            throw new WrongDataException("Parameter的空值个数不符合要求");
        return new Vo<>(returns);
    }

    @GetMapping({"/User/{id}","{id}"})
    @ApiOperation(value = "普通用户的获取information接口",notes = "获取informationClass的展示结构体,需要传入id,token会做检测，无token也可,管理员访问请使用无User的url")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应InformationClass的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "limit",value = "需要详细展示的message数量,若为0则标识全部展示",dataTypeClass = Integer.class,paramType = "query")
    })
    public Vo<InformationClassDto> getInformation(@PathVariable Integer id,@RequestParam(required = false) Integer limit, HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        InformationClassDto informationClassDto = informationClassService.getInformationClass(userDto,id,limit==0?null:limit);
        if (userDto != null) {
            surfService.newSurf(userDto,id, SurfService.INFORMATION_CLASS);
            if (informationClassDto.getLocation() != null) {
                surfService.newSurf(userDto,informationClassDto.getLocation().getLid(),SurfService.LOCATION);
            }
        }
        return new Vo<>(informationClassDto);
    }
    @GetMapping("/Search")
    @ApiOperation(value = "获取全部location接口",notes = "获取informationClass的展示结构体,如果有搜索字符串按字符串规则筛选")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "search", value = "搜索字符串",dataTypeClass = String.class,paramType = "query"),
            @ApiImplicitParam(name = "type", value = "类型限定",dataTypeClass = String.class,paramType = "query")
    })

    public Vo<List<InformationClassDto>> searchInformationClass(@RequestParam(required = false) String search, @RequestParam(required = false) String type) {
        List<InformationClassDto> informationClassDtos = informationClassService.searchInformationClasses(type,search);
        return new Vo<>(informationClassDtos);
    }

    @PostMapping("/Manager")
    @ApiOperation(value = "管理员新建informationClass",notes = "传入informationClass结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "informationClass",value = "要新建的informationClass信息结构体",dataTypeClass = InformationClassIn.class,paramType = "body")
    public Vo<String> newInformation(@RequestBody InformationClassIn informationClass) {
        Integer integer = informationClassService.newInformationClass(informationClass);
        if (integer==1)
            return new Vo<>("新建成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @PutMapping("/Manager")
    @ApiOperation(value = "管理员修改informationClass",notes = "传入informationClass结构体,需要id,需要管理员权限")
    @ApiImplicitParam(name = "informationClass",value = "要修改的informationClass信息结构体,此处一定要修改编号",dataTypeClass = InformationClassIn.class,paramType = "body")
    public Vo<String> updateInformation(@RequestBody InformationClassIn informationClass) throws WrongDataException {
        if (informationClass.getCid() == null) {
            return new Vo<>(Vo.WrongPostParameter,"请输入要修改的编号");
        }
        Integer integer = informationClassService.updateInformationClass(informationClass);
        if (integer != 0 )
            return new Vo<>("修改成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"没有做出修改");
    }

    @DeleteMapping("/Manager/{id}")
    @ApiOperation(value = "管理员删除informationClass",notes = "传入informationClass结构体,需要传入id,需要管理员权限")
    @ApiImplicitParam(name = "id",value = "要删除的informationClass编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<String> deleteInformation(@PathVariable Integer id) {
        Integer integer = informationClassService.deleteInformationClass(id);
        if (integer==1)
            return new Vo<>("删除成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知编号");
    }
}
