package com.example.cse.Utils.Factory;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Mapper.MessageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class InformationClassDtoFactory {
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    LocationMapper locationMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;

    public InformationClassDto getInformationClassDto(InformationClass informationClass){
        InformationClassDto informationClassDto = new InformationClassDto(informationClass);
        informationClassDto.setBasicMessage(messageMapper.getMessageByRule(informationClass.getBasicMessage(),null).get(0));
        informationClassDto.setLocation(locationMapper.getLocationByRule(informationClass.getLocation()).get(0));

        informationClassDto.setKeyAndTypes(keyTypeMapper.getKeyAndTypeByCid(informationClassDto.getCid()));
        informationClassDto.setMessages(messageMapper.getMessageByRule(null, informationClassDto.getCid()));

        return informationClassDto;
    }
}
