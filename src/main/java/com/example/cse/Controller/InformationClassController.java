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
            @ApiImplicitParam(name = "limit",value = "需要详细展示的InformationClass数量",dataTypeClass = Integer.class,paramType = "query",required = false)
    })
    public Vo<InformationClassDto> getMessage(@PathVariable Integer id,@RequestParam(required = false) Integer limit, HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        InformationClassDto informationClassDto = informationClassService.getInformationClass(userDto,id,limit);
        if (userDto != null) {
            surfService.newSurf(userDto,id, SurfService.INFORMATION_CLASS);
        }
        return new Vo<>(informationClassDto);
    }
}
