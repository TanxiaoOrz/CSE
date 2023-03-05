package com.example.cse.Controller;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Service.InformationClassService;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.InformationClassServiceImpl;
import com.example.cse.Service.impl.MessageServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
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

@RestController
@RequestMapping("/cse/InformationClass")
@Api(tags = "informationClass接口")
public class InformationClassController {
    @Autowired
    InformationClassServiceImpl informationClassService;
    @Autowired
    SurfServiceImpl surfService;

    @GetMapping("/User/{id}")
    @ApiOperation(value = "普通用户的获取information接口",notes = "获取informationClass的展示结构体,需要传入id,token会做检测，无token也可")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应InformationClass的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "limit",value = "需要详细展示的InformationClass数量",dataTypeClass = Integer.class,paramType = "query")
    })
    public Vo<InformationClassDto> getMessage(@PathVariable Integer id,@RequestParam(required = false) Integer limit, HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        InformationClassDto informationClassDto = informationClassService.getInformationClass(userDto,id,limit);
        if (userDto != null) {
            surfService.newSurf(userDto,id, SurfService.INFORMATION_CLASS);
            if (informationClassDto.getLocation() != null) {
                surfService.newSurf(userDto,informationClassDto.getLocation().getLid(),SurfService.LOCATION);
            }
        }
        return new Vo<>(informationClassDto);
    }

    @PostMapping("/Manager")
    @ApiOperation(value = "管理员新建message",notes = "传入informationClass结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "informationClass",value = "要新建的minformationClass信息结构体",dataTypeClass = InformationClass.class,paramType = "body")
    public Vo<String> newInformation(@RequestBody InformationClass informationClass) {
        Integer integer = informationClassService.newInformationClass(informationClass);
        if (integer==1)
            return new Vo<>("新建成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @PutMapping("/Manager")
    @ApiOperation(value = "管理员新建message",notes = "传入informationClass结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "informationClass",value = "要修改的informationClass信息结构体,此处一定要修改编号",dataTypeClass = InformationClass.class,paramType = "body")
    public Vo<String> updateInformation(@RequestBody InformationClass informationClass) throws WrongDataException {
        if (informationClass.getCid() == null) {
            return new Vo<>(Vo.WrongPostParameter,"请输入要修改的编号");
        }
        Integer integer = informationClassService.updateInformationClass(informationClass);
        if (integer==1)
            return new Vo<>("修改成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @DeleteMapping("/Manager/{id}")
    @ApiOperation(value = "管理员新建message",notes = "传入informationClass结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "informationClass",value = "要删除的informationClass编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<String> deleteInformation(@PathVariable Integer id) {
        Integer integer = informationClassService.deleteInformationClass(id);
        if (integer==1)
            return new Vo<>("删除成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }
}
