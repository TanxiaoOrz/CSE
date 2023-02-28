package com.example.cse.Service;

import com.example.cse.Dto.UserDto;
import com.example.cse.Utils.Exception.WrongDataException;

import java.util.List;

public interface SurfService {
    int MESSAGE = 0;
    int LOCATION = 1;
    int INFORMATION_CLASS = 2;

    Integer newSurf(UserDto userDto,Integer id,Integer type) throws WrongDataException;

    List<Integer> getSurfRank(UserDto userDto,Integer type);
}
