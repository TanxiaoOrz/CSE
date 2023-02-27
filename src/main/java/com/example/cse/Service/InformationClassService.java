package com.example.cse.Service;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;

public interface InformationClassService {
    InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit);
}
