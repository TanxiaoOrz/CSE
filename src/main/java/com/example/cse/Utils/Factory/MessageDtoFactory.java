package com.example.cse.Utils.Factory;

import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.InformationClassMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Component
public class MessageDtoFactory {

    @Autowired
    InformationClassMapper informationClassMapper;

    @Value("${config.timeScoreMax}")
    Integer timeScoreMax;
    @Value("${config.outTimeMinus}")
    Integer outTimeScore;

    public MessageDto getMessageDto(Message message) {
        InformationClass informationClassByRule = informationClassMapper.getInformationClassByRule(null, message.getMid()).get(0);
        return new MessageDto(message, informationClassByRule);
    }

    public List<MessageDto> getMessageDtosOrderByRankScore(List<Message> messages, UserDto userDto, Integer limit) {
        List<MessageDto> showMessages = new ArrayList<>();
        HashMap<Integer, Integer> messageModel = userDto!=null? userDto.getMessageModel():null;
        Integer timeScore = timeScoreMax;
        for (Message message:messages) {
            MessageDto messageDto = new MessageDto(message);
            messageDto.setRankScore(timeScore,messageModel!=null? messageModel.get(message.getMid()):0,outTimeScore);
            showMessages.add(messageDto);

            timeScore = timeScore>0 ? timeScore-1: 0;

            if (limit!=null&&showMessages.size()>limit) {
                break;
            }
        }
        showMessages.sort(new MessageDto.ScoreComparator());
        return showMessages;
    }

}
