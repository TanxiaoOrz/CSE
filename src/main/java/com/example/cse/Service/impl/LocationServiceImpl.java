package com.example.cse.Service.impl;

import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Service.LocationService;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.LocationDtoFactory;
import com.example.cse.Utils.SearchUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    public List<LocationDto> getLocationsShow(UserDto userDto, Integer locationLimit, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit) {
        List<Location> locations = locationMapper.getLocationByRule(null, null);
        List<LocationDto> locationDtos = locationDtoFactory.getLocationsByRank(locations,userDto);
        for (LocationDto locationDto:locationDtos) {
            locationDtoFactory.calculateShow(locationDto,userDto,informationLimit,messageLimit,informationMessageLimit);
        }
        return locationDtos;
    }

    @Override
    public List<LocationDto> getLocationsAll(UserDto userDto) {
        List<Location> locations = locationMapper.getLocationByRule(null, null);
        return locationDtoFactory.getLocationsByRank(locations,userDto);
    }

    @Override
    public Integer newLocation(Location location) {
        return locationMapper.newLocation(location);
    }

    @Override
    public Integer updateLocation(Location location) throws WrongDataException {
        Location old;
        try {
            old = locationMapper.getLocationByRule(location.getLid(), null).get(0);
        }catch (ArrayIndexOutOfBoundsException e) {
            throw new WrongDataException("错误的地点编号");
        }
        if (location.checkUpdate(old)) {
            throw new WrongDataException("没有修改");
        }

        return locationMapper.updateLocation(location);
    }

    @Override
    public Integer deleteLocation(Integer lid) {
        return locationMapper.deleteLocation(lid);
    }

    @Override
    public List<LocationDto> searchLocations(String search) {
        List<String> adds = new ArrayList<>();
        List<String> minuses = new ArrayList<>();
        List<String> defaults = new ArrayList<>();

        SearchUtils.splitSearch(search,adds,minuses,defaults);

        List<Location> locations = locationMapper.searchLocation(defaults, adds, minuses);

        return locationDtoFactory.getLocationsByRank(locations);
    }
}
