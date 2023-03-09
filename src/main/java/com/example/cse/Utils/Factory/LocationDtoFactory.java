package com.example.cse.Utils.Factory;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.MessageDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Mapper.MessageMapper;
import com.example.cse.Mapper.SurfMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class LocationDtoFactory {
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    MessageDtoFactory messageDtoFactory;
    @Autowired
    InformationClassDtoFactory informationClassDtoFactory;
    @Autowired
    SurfMapper surfMapper;

    @Value("${config.popular}")
    Integer popularScore;

    private float averageScore;

    public LocationDto getLocationDto(Location location) {
        LocationDto locationDto = new LocationDto(location);
        locationDto.setBasicMessage(messageMapper.getMessageByRule(location.getBasicMessage(),null,null).get(0));

        return locationDto;
    }

    public void calculateShow(LocationDto locationDto, UserDto userDto, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit) {
        locationDto.setMessages(messageMapper.getMessageByRule(null,null, locationDto.getLid()));
        locationDto.setInformationClasses(informationClassMapper.getInformationClassByRule(null,null, locationDto.getLid()));

        List<InformationClassDto> informationShows = informationClassDtoFactory.getInformationClassDtosByRankScore(locationDto.getInformationClasses(), userDto);

        ArrayList<InformationClassDto> deletes = new ArrayList<>();
        for (InformationClassDto informationClassDto:informationShows) {

            if (informationClassDtoFactory.calculateShowMessages(informationClassDto,userDto,informationMessageLimit)) {
                deletes.add(informationClassDto);
            }
        }
        informationShows.removeAll(deletes);
        if (informationLimit!=null&&informationShows.size() > informationLimit) {
            locationDto.setInformationShows(informationShows.subList(0,informationLimit));
        }else
            locationDto.setInformationShows(informationShows);

        List<MessageDto> messageShows = messageDtoFactory.getMessageDtosOrderByRankScore(locationDto.getMessages(), userDto);
        if (messageLimit!=null&&messageShows.size()>messageLimit) {
            locationDto.setMessageShows(messageShows.subList(0,messageLimit));
        }else {
            locationDto.setMessageShows(messageShows);
        }
    }

    public  List<LocationDto> getLocationsByRank(List<Location> locations, UserDto userDto) {
        if (userDto == null) {
            return getLocationsByRank(locations);
        }else {
            List<LocationDto> locationDtos = new ArrayList<>();
            Float averageSurfCountLocation = surfMapper.getAverageSurfCountLocation();
            ConcurrentHashMap<Integer, Integer> locationModels = userDto.getLocationModels();
            averageScore = averageSurfCountLocation!=null?averageSurfCountLocation:0;
            for (Location location : locations) {
                LocationDto locationDto = getLocationDto(location);
                Integer modelScore = locationModels.get(locationDto.getLid());
                if (modelScore == null) {
                    modelScore = 0;
                }
                locationDto.setRankScore(calculateSurfScore(locationDto) + modelScore);
                locationDtos.add(locationDto);
            }
            locationDtos.sort(new LocationDto.ScoreComparator());
            return locationDtos;
        }
    }

    public  List<LocationDto> getLocationsByRank(List<Location> locations) {
        List<LocationDto> locationDtos = new ArrayList<>();
        Float averageSurfCountLocation = surfMapper.getAverageSurfCountLocation();
        averageScore = averageSurfCountLocation!=null?averageSurfCountLocation:0;
        for (Location location : locations) {
            LocationDto locationDto = getLocationDto(location);
            locationDto.setRankScore(calculateSurfScore(locationDto));
            locationDtos.add(locationDto);
        }
        locationDtos.sort(new LocationDto.ScoreComparator());
        return locationDtos;
    }

    private Integer calculateSurfScore(LocationDto locationDto) {
        Integer surfCountLocation = surfMapper.getSurfCountLocation(locationDto.getLid());
        if (surfCountLocation == null) {
            return 0;
        }
        if (surfCountLocation >= averageScore) {
            return popularScore;
        }else
            return 0;
    }
}
