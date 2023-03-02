package com.example.cse.Utils.Factory;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Mapper.MapMapper;
import com.example.cse.Mapper.MessageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class LocationDtoFactory {
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    MapMapper mapMapper;
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    MessageDtoFactory messageDtoFactory;
    @Autowired
    InformationClassDtoFactory informationClassDtoFactory;

    public LocationDto getLocationDto(Location location) {
        LocationDto locationDto = new LocationDto(location);
        locationDto.setBasicMessage(messageMapper.getMessageByRule(location.getBasicMessage(),null,null).get(0));
        locationDto.setMapBelong(mapMapper.getMapByMid(location.getMapBelong()));
        locationDto.setMapOwn(mapMapper.getMapByMid(location.getMapOwn()));
        locationDto.setInformationClasses(informationClassMapper.getInformationClassByRule(null,null, locationDto.getLid()));
        locationDto.setMessages(messageMapper.getMessageByRule(null,null, locationDto.getLid()));
        return locationDto;
    }

    public void calculateShow(LocationDto locationDto, UserDto userDto, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit) {
        List<InformationClassDto> informationShows = informationClassDtoFactory.getInformationClassDtosByRankScore(locationDto.getInformationClasses(), userDto);

        ArrayList<InformationClassDto> deletes = new ArrayList<>();
        for (InformationClassDto informationClassDto:informationShows) {
            if (informationClassDtoFactory.calculateShowMessages(informationClassDto,userDto,informationMessageLimit)) {
                deletes.add(informationClassDto);
            }
        }
        informationShows.removeAll(deletes);

        while (informationShows.size()>informationLimit) {
            informationShows.remove(informationLimit.intValue());
        }

        locationDto.setInformationShows(informationShows);

        List<MessageDto> messageShows = messageDtoFactory.getMessageDtosOrderByRankScore(locationDto.getMessages(), userDto);
        if (messageShows.size()>messageLimit) {
            locationDto.setMessageShows(messageShows.subList(0,messageLimit));
        }else {
            locationDto.setMessageShows(messageShows);
        }
    }
}
