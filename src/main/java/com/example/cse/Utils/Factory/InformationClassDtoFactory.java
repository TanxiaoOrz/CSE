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

    @Value("${config.timeScoreMax}")
    Integer timeScoreMax;
    @Value("${config.outTimeMinus}")
    Integer outTimeScore;

    public InformationClassDto getInformationClassDto(InformationClass informationClass) {
        InformationClassDto informationClassDto = new InformationClassDto(informationClass);
        informationClassDto.setBasicMessage(messageMapper.getMessageByRule(informationClass.getBasicMessage(),null).get(0));
        informationClassDto.setLocation(locationMapper.getLocationByRule(informationClass.getLocation()).get(0));

        informationClassDto.setKeyAndTypes(keyTypeMapper.getKeyAndTypeByCid(informationClassDto.getCid()));
        informationClassDto.setMessages(messageMapper.getMessageByRule(null, informationClassDto.getCid()));

        return informationClassDto;
    }

    public boolean calculateShowMessages(InformationClassDto informationClassDto, UserDto userDto,Integer limit) {
        boolean reachLimitation = true;

        List<MessageDto> showMessages = new ArrayList<>();
        informationClassDto.setShowMessages(showMessages);
        HashMap<Integer, Integer> messageModel = userDto.getMessageModel();
        Integer timeScore = timeScoreMax;
        for (Message message:informationClassDto.getMessages()) {
            MessageDto messageDto = new MessageDto(message);
            messageDto.setRankScore(timeScore, messageModel.get(message.getMid()),outTimeScore);
            showMessages.add(messageDto);

            timeScore = timeScore>0 ? timeScore-1: 0;

            if (limit!=null&&showMessages.size()>limit) {
                reachLimitation = false;
                break;
            }
        }
        showMessages.sort(new MessageDto.ScoreComparator());
        return reachLimitation;
    }

    public boolean calculateShowMessages(InformationClassDto informationClassDto,Integer limit) {
        boolean reachLimitation = true;

        List<MessageDto> showMessages = new ArrayList<>();
        informationClassDto.setShowMessages(showMessages);
        Integer timeScore = timeScoreMax;
        for (Message message:informationClassDto.getMessages()) {
            MessageDto messageDto = new MessageDto(message);
            messageDto.setRankScore(timeScore,0,outTimeScore);
            showMessages.add(messageDto);

            timeScore = timeScore>0 ? timeScore-1: 0;

            if (limit!=null&&showMessages.size()>limit) {
                reachLimitation = false;
                break;
            }
        }
        showMessages.sort(new MessageDto.ScoreComparator());
        return reachLimitation;
    }
}
