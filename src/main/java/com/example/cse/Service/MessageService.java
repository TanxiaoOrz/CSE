package com.example.cse.Service;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.MessageIn;

public interface MessageService {

    MessageDto getMessage(Integer mid) throws WrongDataException;

    Integer newMessage(MessageIn message);

    Integer updateMessage(MessageIn message) throws WrongDataException;

    Integer deleteMessage(Integer mid);

}
