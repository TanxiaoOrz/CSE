package com.example.cse.Service;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.InformationClassIn;
import com.example.cse.Vo.Suggest;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface InformationClassService {
    InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit);

    Integer newInformationClass(InformationClassIn informationClass);

    Integer updateInformationClass(InformationClassIn informationClass) throws WrongDataException;

    Integer deleteInformationClass(Integer cid);

    List<InformationClassDto> getInformationClassesShow(UserDto userDto, Integer classLimit, Integer messageLimit, String type);

    List<InformationClassDto> searchInformationClasses(String type,String search);

    List<Suggest> getInformationClassWordCloud(UserDto userDto, Integer count, String type);
}
