package com.example.cse.Controller;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Service.MessageService;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.MessageServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/cse/Message")
@Api(tags = "message接口")
public class MessageController {
    @Autowired
    MessageServiceImpl messageService;
    @Autowired
    SurfServiceImpl surfService;

    @GetMapping("/User/{id}")
    @ApiOperation(value = "普通用户的获取message接口",notes = "获取message的展示结构体,需要传入id,如果进行了token的传递")
    @ApiImplicitParam(name = "id",value = "对应message的编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<MessageDto> getMessage(@PathVariable Integer id, HttpServletRequest request) throws WrongDataException {
        UserDto userDto = (UserDto) request.getAttribute("UserDto");
        MessageDto message = messageService.getMessage(id);
        if (userDto != null) {
            surfService.newSurf(userDto,id, SurfService.MESSAGE);
            if (message.getLocations() != null) {
                for (Location location : message.getLocations()) {
                    surfService.newSurf(userDto,location.getLid(),SurfService.LOCATION);
                }
            }
            if (message.getRelationInformationClass() != null)
                surfService.newSurf(userDto,message.getRelationInformationClass().getCid(),SurfService.INFORMATION_CLASS);
        }
        return new Vo<>(message);
    }
}
