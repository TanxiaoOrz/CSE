package com.example.cse.Service;

import com.example.cse.Dto.CalenderDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.Calender;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.CalenderIn;
import com.example.cse.Vo.CalenderOut;

import java.util.List;

public interface CalenderService {

    CalenderOut getUserCalender(UserDto userDto) throws WrongDataException;

    Integer updateUserCalender(UserDto userDto, CalenderIn calenderIn) throws NoDataException;

    Integer deleteUserCalender(UserDto userDto, CalenderIn calenderIn) throws NoDataException;

    Integer newUserCalender(UserDto userDto,CalenderIn calenderIn) throws NoDataException;
}
