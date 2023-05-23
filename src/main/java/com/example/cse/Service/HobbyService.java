package com.example.cse.Service;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.HobbyIn;
import com.example.cse.Vo.UserHobbyIn;

import java.util.List;

public interface HobbyService {

    Integer newHobby(HobbyIn hobbyIn) throws NoDataException;

    List<HobbyDto> getHobbyAll();

    List<HobbyDto> getHobbyByUserDegree(UserDto userDto, String degree);

    Integer updateUserHobby(UserHobbyIn userHobby, UserDto userDto) throws NoDataException;

}
