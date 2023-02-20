package com.example.cse.Utils.Factory;

import com.example.cse.Dto.CalenderDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Entity.UserClass.Calender;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Mapper.MessageMapper;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.TypeString;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CalenderDtoFactory {
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    LocationMapper locationMapper;

    public CalenderDto getCalenderDto(Calender calender) throws WrongDataException {
        TypeString string = new Gson().fromJson(calender.getRelationFunction(), TypeString.class);
        switch (string.getType()){
            case "message":{
                Message message = new Message();
                message.setMid(string.getId());
                return new CalenderDto<>(calender,messageMapper.getMessageByRule(message),"message");
            }
            case "informationClass":{
                InformationClass informationClass = new InformationClass();
                informationClass.setCid(string.getId());
                return new CalenderDto<>(calender,informationClassMapper.getInformationClassByRule(informationClass),"information");
            }
            case "location": {
                Location location = new Location();
                location.setLid(string.getId());
                return new CalenderDto<>(calender,locationMapper.getLocationByRule(location),"Location");
            }
            default: throw new WrongDataException("错误的RelationFunction存储,"
                    +"Calender: uid = "+calender.getUid()+", time = "+calender.getTime());
        }
    }

    public List<CalenderDto> getCalenderDtos(List<Calender> calenders) throws WrongDataException {
        List<CalenderDto> calenderDtos = new ArrayList<>();
        for (Calender calender: calenders){
            calenderDtos.add(getCalenderDto(calender));
        }
        return calenderDtos;
    }
}
