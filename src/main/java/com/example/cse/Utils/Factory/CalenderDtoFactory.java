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
import java.util.Objects;

@Component
public class CalenderDtoFactory {
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    LocationMapper locationMapper;

    public CalenderDto<? super Object> getCalenderDto(Calender calender) throws WrongDataException {
        TypeString string = new Gson().fromJson(calender.getRelationFunction(), TypeString.class);
        switch (string.getType()){
            case "message":{
                return new CalenderDto<>(calender,messageMapper.getMessageByRule(string.getId(),null,null).get(0),"message");
            }
            case "informationClass":{
                return new CalenderDto<>(calender,informationClassMapper.getInformationClassByRule(string.getId(),null,null).get(0),"information");
            }
            case "location": {
                return new CalenderDto<>(calender,locationMapper.getLocationByRule(string.getId()).get(0),"Location");
            }
            default: throw new WrongDataException("错误的RelationFunction存储,"
                    +"Calender: uid = "+calender.getUid()+", time = "+calender.getTime());
        }
    }

    public List<CalenderDto<? super Object>> getCalenderDtos(List<Calender> calenders) throws WrongDataException {
        List<CalenderDto<? super Object>> calenderDtos = new ArrayList<>();
        for (Calender calender: calenders){
            calenderDtos.add(getCalenderDto(calender));
        }
        return calenderDtos;
    }
}
