package com.example.cse.Controller;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Service.MessageService;
import com.example.cse.Service.impl.MessageServiceImpl;
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

@RestController
@RequestMapping("/cse/Message")
@Api(tags = "message接口")
public class MessageController {
    @Autowired
    MessageServiceImpl messageService;

    @GetMapping("/User/{id}")
    @ApiOperation(value = "普通用户的获取message接口",notes = "获取message的展示结构体,需要传入id")
    @ApiImplicitParam(name = "id",value = "对应message的编号",dataTypeClass = Integer.class,paramType = "path")
    public Vo<MessageDto> getMessage(@PathVariable Integer id) throws WrongDataException {
        MessageDto message = messageService.getMessage(id);
        return new Vo<>(message);
    }
}
