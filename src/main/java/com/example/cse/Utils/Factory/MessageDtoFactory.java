package com.example.cse.Utils.Factory;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Mapper.SurfMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class MessageDtoFactory {

    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    LocationMapper locationMapper;
    @Autowired
    SurfMapper surfMapper;

    @Value("${config.timeScoreMax}")
    Integer timeScoreMax;
    @Value("${config.outTimeMinus}")
    Integer outTimeScore;
    @Value("${config.popular}")
    Integer popularScore;

    float averageMessage;

    public MessageDto getMessageDto(Message message) {
        List<InformationClass> relativeInformations = informationClassMapper.getInformationClassByRule(null, message.getMid(),null);
        List<Location> locations = locationMapper.getLocationByRule(null, message.getMid());
        MessageDto messageDto = new MessageDto(message);
        messageDto.setLocations(locations);
        messageDto.setRelationInformationClass(relativeInformations);
        return messageDto;
    }

    public List<MessageDto> getMessageDtosOrderByRankScore(List<Message> messages, UserDto userDto) {
        List<MessageDto> showMessages = new ArrayList<>();
        ConcurrentHashMap<Integer, Integer> messageModel = userDto!=null? userDto.getMessageModel():null;
        Integer timeScore = timeScoreMax;
        Float average = surfMapper.getAverageSurfCountMessage();
        averageMessage = average!=null?average:0;
        for (Message message:messages) {
            MessageDto messageDto = new MessageDto(message);
            messageDto.setRankScore(timeScore,messageModel!=null? messageModel.get(message.getMid()):0,calculateSurfScore(messageDto),outTimeScore);
            showMessages.add(messageDto);

            timeScore = timeScore>0 ? timeScore-1: 0;

        }
        showMessages.sort(new MessageDto.ScoreComparator());
        return showMessages;
    }

    private Integer calculateSurfScore(MessageDto messageDto) {
        Integer surfCountMessage = surfMapper.getSurfCountMessage(messageDto.getMid());
        if (surfCountMessage == null) {
            return 0;
        }
        if (surfCountMessage >=averageMessage)
            return popularScore;
        else
            return 0;
    }

}
