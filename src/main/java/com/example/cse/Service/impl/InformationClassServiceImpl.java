package com.example.cse.Service.impl;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Service.InformationClassService;
import com.example.cse.Utils.Factory.InformationClassDtoFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InformationClassServiceImpl implements InformationClassService {
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    InformationClassDtoFactory informationClassDtoFactory;

    @Override
    public InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit) {
        InformationClass informationClass = informationClassMapper.getInformationClassByRule(cid,null,null).get(0);

        InformationClassDto informationClassDto = informationClassDtoFactory.getInformationClassDto(informationClass);

        informationClassDtoFactory.calculateShowMessages(informationClassDto,userDto,limit);

        return informationClassDto;
    }
}
