package com.example.cse.Service.impl;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.MessageMapper;
import com.example.cse.Service.MessageService;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.MessageDtoFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    MessageMapper messageMapper;

    @Autowired
    MessageDtoFactory messageDtoFactory;


    @Override
    public MessageDto getMessage(Integer mid) throws WrongDataException {
        if (mid == null) {
            throw new WrongDataException("缺少mid");
        }
        Message message = messageMapper.getMessageByRule(mid,null).get(0);
        return messageDtoFactory.getMessageDto(message);
    }
}
