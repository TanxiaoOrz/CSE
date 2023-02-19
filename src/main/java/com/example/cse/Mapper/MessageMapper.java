package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Message;

import java.util.List;

public interface MessageMapper {

    Message getMessageByRule(Message message);

    Integer newMessage(Message message);

    Integer updateMessage(Message message);

}
