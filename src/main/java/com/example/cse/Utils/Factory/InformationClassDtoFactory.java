package com.example.cse.Utils.Factory;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Mapper.MessageMapper;
import com.example.cse.Mapper.SurfMapper;
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
    SurfMapper surfMapper;
    @Autowired
    MessageDtoFactory messageDtoFactory;

    @Value("${config.timeScoreMax}")
    Integer timeScoreMax;
    @Value("${config.outTimeMinus}")
    Integer outTimeScore;

    @Value("${config.popular}")
    Integer popularScore;

    private float averageInformationClass;

    public InformationClassDto getInformationClassDto(InformationClass informationClass) {
        InformationClassDto informationClassDto = new InformationClassDto(informationClass);
        informationClassDto.setBasicMessage(messageMapper.getMessageByRule(informationClass.getBasicMessage(),null,null).get(0));
        if (informationClass.getLocation() != null) {
            informationClassDto.setLocation(locationMapper.getLocationByRule(informationClass.getLocation(),null).get(0));
        }

        informationClassDto.setKeyAndTypes(keyTypeMapper.getKeyAndTypeByCid(informationClassDto.getCid()));
        informationClassDto.setMessages(messageMapper.getMessageByRule(null, informationClassDto.getCid(),null));

        return informationClassDto;
    }


    public boolean calculateShowMessages(InformationClassDto informationClassDto, UserDto userDto,Integer limit) {
        List<MessageDto> showMessages = messageDtoFactory.getMessageDtosOrderByRankScore(informationClassDto.getMessages(), userDto);
        if (limit == null) {
            informationClassDto.setShowMessages(showMessages);
            return true;
        }
        if (showMessages.size()>limit) {
            informationClassDto.setShowMessages(showMessages.subList(0,limit));
            return true;
        }
        informationClassDto.setShowMessages(showMessages);
        return showMessages.size()==limit;
    }

    public List<InformationClassDto> getInformationClassDtosByRankScore(List<InformationClass> informationClasses, UserDto userDto) {
        List<InformationClassDto> informationClassDtos =new ArrayList<>();
        Float average = surfMapper.getAverageSurfCountInformationClass();
        averageInformationClass = average!=null?average:0;
        for (InformationClass informationClass:informationClasses) {
            InformationClassDto informationClassDto = getInformationClassDto(informationClass);

            if (userDto != null) {
                informationClassDto.setRankScore(userDto.getKeywordModels(),userDto.getInformationClassModel(),calculateSurfScore(informationClassDto));
            }else {
                informationClassDto.setRankScore(calculateSurfScore(informationClassDto));
            }

            informationClassDtos.add(informationClassDto);
        }
        informationClassDtos.sort(new InformationClassDto.ScoreComparator());
        return informationClassDtos;
    }

    private Integer calculateSurfScore(InformationClassDto informationClassDto) {
        Integer surfCountInformationClass = surfMapper.getSurfCountInformationClass(informationClassDto.getCid());
        if (surfCountInformationClass == null) {
            return 0;
        }
        if (surfCountInformationClass >=averageInformationClass)
            return popularScore;
        else
            return 0;
    }
}
