package com.example.cse.Service;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;

public interface InformationClassService {
    InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit);

    Integer newInformationClass(InformationClass informationClass);

    Integer updateInformationClass(InformationClass informationClass);

    Integer deleteInformationClass(Integer cid);

}
