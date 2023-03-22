package com.example.cse.Service.impl;

import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Mapper.FavouriteMapper;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Mapper.LocationMapper;
import com.example.cse.Service.LocationService;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.LocationDtoFactory;
import com.example.cse.Utils.SearchUtils;
import com.example.cse.Vo.LocationIn;
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
    @Autowired
    FavouriteMapper favouriteMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;


    @Override
    public LocationDto getLocation(Integer lid, UserDto userDto,Integer informationLimit, Integer messageLimit, Integer informationMessageLimit) {
        Location location = locationMapper.getLocationByRule(lid, null).get(0);
        LocationDto locationDto = locationDtoFactory.getLocationDto(location);
        locationDtoFactory.calculateShow(locationDto,userDto,informationLimit,messageLimit,informationMessageLimit);
        if (userDto == null) {
            locationDto.setIsFavourite(0);
        }else
            locationDto.setIsFavourite(favouriteMapper.getFavouriteLidByUid(userDto.getUid()).contains(locationDto.getLid())?1:0);
        return locationDto;
    }

    @Override
    public List<LocationDto> getLocationsShow(UserDto userDto, Integer locationLimit, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit) {
        List<Location> locations = locationMapper.getLocationByRule(null, null);
        List<LocationDto> locationDtos = locationDtoFactory.getLocationsByRank(locations,userDto);
        for (LocationDto locationDto:locationDtos) {
            locationDtoFactory.calculateShow(locationDto,userDto,informationLimit,messageLimit,informationMessageLimit);
        }
        if (locationDtos.size()<locationLimit)
            return locationDtos;
        else
            return locationDtos.subList(0,locationLimit);
    }

    @Override
    public Integer newLocation(LocationIn location) {
        location.checkZeroToNull();
        Integer integer = locationMapper.newLocation(location);

        for (Integer kid:location.getKeyAndTypes()) {
            keyTypeMapper.newKeyAndTypeLinkLocation(location.getLid(),kid);
        }


        return integer;
    }

    @Override
    public Integer updateLocation(LocationIn location) throws WrongDataException {
        Location old;
        try {
            old = locationMapper.getLocationByRule(location.getLid(), null).get(0);
        }catch (IndexOutOfBoundsException e) {
            throw new WrongDataException("错误的地点编号");
        }
        Integer integer = 0;
        if (!location.checkUpdate(old)) {
            location.checkZeroToNull();
            integer = locationMapper.updateLocation(location);
        }
        List<Integer> keys = location.getKeyAndTypes();
        if (keys != null) {
            List<Integer> olds = keyTypeMapper.getKidsByLid(location.getLid());
            ArrayList<Integer> delete = new ArrayList<>(olds);
            delete.removeAll(keys);
            ArrayList<Integer> insert = new ArrayList<>(keys);
            insert.removeAll(olds);
            for (Integer kid : delete) {
                integer += keyTypeMapper.deleteKeyAndTypeLinkLocation(location.getLid(),kid);
            }
            for (Integer kid : insert) {
                integer += keyTypeMapper.newKeyAndTypeLinkLocation(location.getLid(),kid);
            }
        }

        return integer;
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
