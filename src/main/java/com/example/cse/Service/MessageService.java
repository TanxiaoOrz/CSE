package com.example.cse.Service;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.MessageIn;

import java.util.List;

public interface MessageService {

    MessageDto getMessage(Integer mid, UserDto userDto) throws WrongDataException;

    MessageDto getMessageOut(Integer mid) throws WrongDataException;

    List<MessageDto> searchMessages(String search);

    List<MessageDto> searchMessagesOut(String search);

    Integer newMessage(MessageIn message);

    Integer updateMessage(MessageIn message) throws WrongDataException;

    Integer deleteMessage(Integer mid);

}
