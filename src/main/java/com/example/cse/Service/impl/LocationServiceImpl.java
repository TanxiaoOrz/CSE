package com.example.cse.Service.impl;

import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Service.LocationService;
import com.example.cse.Utils.Factory.LocationDtoFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LocationServiceImpl implements LocationService {

    @Autowired
    LocationMapper locationMapper;
    @Autowired
    LocationDtoFactory locationDtoFactory;


    @Override
    public LocationDto getLocation(Integer lid, UserDto userDto,Integer informationLimit, Integer messageLimit, Integer informationMessageLimit) {
        Location location = locationMapper.getLocationByRule(lid, null).get(0);
        LocationDto locationDto = locationDtoFactory.getLocationDto(location);
        locationDtoFactory.calculateShow(locationDto,userDto,informationLimit,messageLimit,informationMessageLimit);
        return locationDto;
    }

    @Override
    public List<LocationDto> getLocations(UserDto userDto) {
        return null;
    }

    @Override
    public Integer newLocation(Location location) {
        return null;
    }

    @Override
    public Integer updateLocation(Location location) {
        return null;
    }
}
