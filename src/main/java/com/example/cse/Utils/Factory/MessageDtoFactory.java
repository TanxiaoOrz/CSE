package com.example.cse.Utils.Factory;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.InformationClassMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class MessageDtoFactory {

    @Autowired
    InformationClassMapper informationClassMapper;

    public MessageDto getMessageDto(Message message) {
        InformationClass informationClassByRule = informationClassMapper.getInformationClassByRule(null, message.getMid());
        return new MessageDto(message, informationClassByRule);
    }

    public List<MessageDto> getMessageDtos(List<Message> messages) {
        List<MessageDto> messageDtos = new ArrayList<>();
        for (Message message:messages) {
            messageDtos.add(getMessageDto(message));
        }
        return messageDtos;
    }

}
