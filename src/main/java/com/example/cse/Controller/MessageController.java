package com.example.cse.Controller;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Service.SurfService;
import com.example.cse.Service.impl.MessageServiceImpl;
import com.example.cse.Service.impl.SurfServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.MessageIn;
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
@RequestMapping("/cse/Message")
@Api(tags = "message接口")
public class MessageController {
    @Autowired
    MessageServiceImpl messageService;
    @Autowired
    SurfServiceImpl surfService;

    @GetMapping({"/User/{id}","/{id}"})
    @ApiOperation(value = "普通用户的获取message接口",notes = "获取message的展示结构体,需要传入id,token会做检测，无token也可，管理员访问请使用无User的url")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "对应message的编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "out",value = "是否是过时的消息,0代表不是",dataTypeClass = Integer.class,paramType = "query",example = "0")
    })
    public Vo<MessageDto> getMessage(@PathVariable Integer id,@RequestParam Integer out, HttpServletRequest request) throws NoDataException {
        if (out == 0){
            UserDto userDto = (UserDto) request.getAttribute("UserDto");
            MessageDto message = messageService.getMessage(id,userDto);
            if (message == null) {
                throw new NoDataException(Vo.WrongPostParameter,"没有找到该消息，可能输入了错误的mid或该mid已过时，请在过时消息中搜索");
            }

                    surfService.newSurf(userDto, id, SurfService.MESSAGE);
                    if (message.getLocations() != null) {
                        for (Location location : message.getLocations()) {
                            surfService.newSurf(userDto, location.getLid(), SurfService.LOCATION);
                        }
                    }
                    if (message.getRelationInformationClass() != null)
                        for (InformationClass informationClass : message.getRelationInformationClass()) {
                            surfService.newSurf(userDto, informationClass.getCid(), SurfService.INFORMATION_CLASS);
                        }

            return new Vo<>(message);
        }else {
            MessageDto message = messageService.getMessageOut(id);
            if (message == null) {
                throw new NoDataException(Vo.WrongPostParameter,"没有找到该消息可能输入了错误的mid或该消息未过时，请在过时消息中搜索");
            }
            return new Vo<>(message);
        }
    }

    @GetMapping("/Search")
    @ApiOperation(value = "获取全部message接口",notes = "获取message的展示结构体,如果有搜索字符串按字符串规则筛选")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "search", value = "搜索字符串",dataTypeClass = String.class,paramType = "query"),
            @ApiImplicitParam(name = "out",value = "是否是过时的消息,0代表不是",dataTypeClass = Integer.class,paramType = "query",example = "0")
    })
    public Vo<List<MessageDto>> searchMessages(@RequestParam(required = false) String search,@RequestParam Integer out) {
        List<MessageDto> messages;
        if (out == 0)
            messages= messageService.searchMessages(search);
        else
            messages= messageService.searchMessagesOut(search);
        return new Vo<>(messages);
    }

    @PostMapping("/Manager")
    @ApiOperation(value = "管理员新建message",notes = "传入messageIn结构体,无需传入id,需要管理员权限")
    @ApiImplicitParam(name = "message",value = "要新建的message信息结构体",dataTypeClass = MessageIn.class,paramType = "body")
    public Vo<String> newMessage(@RequestBody MessageIn message) {
        Integer integer = messageService.newMessage(message);
        if (integer != 0)
            return new Vo<>("新建成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @PutMapping("/Manager")
    @ApiOperation(value = "管理员修改message",notes = "传入messageIn结构体,需要传入id,需要管理员权限")
    @ApiImplicitParam(name = "message",value = "要修改的message信息结构体,此处一定要修改编号",dataTypeClass = MessageIn.class,paramType = "body")
    public Vo<String> updateMessage(@RequestBody MessageIn message) throws WrongDataException {
        if (message.getMid() == null) {
            return new Vo<>(Vo.WrongPostParameter,"请输入要修改的编号");
        }
        Integer integer = messageService.updateMessage(message);
        if (integer != 0)
            return new Vo<>("修改成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"未知错误");
    }

    @DeleteMapping("/Manager/{id}")
    @ApiOperation(value = "管理员删除message",notes = "需要传入id,需要管理员权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "要删除的message编号",dataTypeClass = Integer.class,paramType = "path"),
            @ApiImplicitParam(name = "out",value = "是否是过时的消息,0代表不是",dataTypeClass = Integer.class,paramType = "query",example = "0")
    })
    public Vo<String> deleteMessage(@PathVariable Integer id,@RequestParam Integer out) {
        Integer integer = messageService.deleteMessage(id,out!=0);
        if (integer==1)
            return new Vo<>("删除成功");
        else
            return new Vo<>(Vo.WrongPostParameter,"错误的编号");
    }
}
