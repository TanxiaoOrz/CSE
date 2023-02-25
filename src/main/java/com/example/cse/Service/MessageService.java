package com.example.cse.Service;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Utils.Exception.WrongDataException;

public interface MessageService {

    MessageDto getMessage(Integer mid) throws WrongDataException;

}
