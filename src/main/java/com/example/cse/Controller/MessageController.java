package com.example.cse.Controller;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Service.MessageService;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.MessageServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.MessageIn;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
                for (InformationClass informationClass:message.getRelationInformationClass()) {
                    surfService.newSurf(userDto,informationClass.getCid(),SurfService.INFORMATION_CLASS);
                }

        }
        return new Vo<>(message);
    }

    @PostMapping("/Manager")
    @ApiOperation(value = "管理员新建message",notes = "传入messageIn结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "message",value = "要新建的message信息结构体",dataTypeClass = MessageIn.class,paramType = "body")
    public Vo<String> newMessage(@RequestBody MessageIn message) {
        Integer integer = messageService.newMessage(message);
        if (integer==1)
            return new Vo<>("新建成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @PutMapping("/Manager")
    @ApiOperation(value = "管理员新建message",notes = "传入messageIn结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "message",value = "要修改的message信息结构体,此处一定要修改编号",dataTypeClass = MessageIn.class,paramType = "body")
    public Vo<String> updateMessage(@RequestBody MessageIn message) throws WrongDataException {
        if (message.getMid() == null) {
            return new Vo<>(Vo.WrongPostParameter,"请输入要修改的编号");
        }
        Integer integer = messageService.updateMessage(message);
        if (integer==1)
            return new Vo<>("修改成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @DeleteMapping("/Manager/{id}")
    @ApiOperation(value = "管理员新建message",notes = "传入messageIn结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "message",value = "要删除的message编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<String> deleteMessage(@PathVariable Integer id) {
        Integer integer = messageService.deleteMessage(id);
        if (integer==1)
            return new Vo<>("删除成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"错误的编号");
    }
}
