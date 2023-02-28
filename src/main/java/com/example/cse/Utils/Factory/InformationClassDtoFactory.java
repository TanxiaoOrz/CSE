package com.example.cse.Utils.Factory;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Mapper.MessageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Component
public class InformationClassDtoFactory {
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    LocationMapper locationMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Autowired
    MessageDtoFactory messageDtoFactory;

    @Value("${config.timeScoreMax}")
    Integer timeScoreMax;
    @Value("${config.outTimeMinus}")
    Integer outTimeScore;

    public InformationClassDto getInformationClassDto(InformationClass informationClass) {
        InformationClassDto informationClassDto = new InformationClassDto(informationClass);
        informationClassDto.setBasicMessage(messageMapper.getMessageByRule(informationClass.getBasicMessage(),null).get(0));
        if (informationClass.getLocation() != null) {
            informationClassDto.setLocation(locationMapper.getLocationByRule(informationClass.getLocation()).get(0));
        }

        informationClassDto.setKeyAndTypes(keyTypeMapper.getKeyAndTypeByCid(informationClassDto.getCid()));
        informationClassDto.setMessages(messageMapper.getMessageByRule(null, informationClassDto.getCid()));

        return informationClassDto;
    }

    public boolean calculateShowMessages(InformationClassDto informationClassDto, UserDto userDto,Integer limit) {
        List<MessageDto> showMessages = messageDtoFactory.getMessageDtosOrderByRankScore(informationClassDto.getMessages(), userDto, limit);
        informationClassDto.setShowMessages(showMessages);
        return showMessages.size()==limit;
    }
}
