package com.example.cse.Service;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Utils.Exception.WrongDataException;

import java.util.List;

public interface InformationClassService {
    InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit);

    Integer newInformationClass(InformationClass informationClass);

    Integer updateInformationClass(InformationClass informationClass) throws WrongDataException;

    Integer deleteInformationClass(Integer cid);

    List<InformationClassDto> getInformationClassesShow(UserDto userDto, Integer classLimit, Integer messageLimit, String type);

    List<InformationClassDto> getInformationClassesAll(UserDto userDto, String type);

    List<InformationClassDto> searchInformationClasses(String type,String search);
}
