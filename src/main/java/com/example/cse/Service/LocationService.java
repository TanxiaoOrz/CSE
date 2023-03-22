package com.example.cse.Service;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.LocationIn;

import java.util.List;

public interface LocationService {
    LocationDto getLocation(Integer lid, UserDto userDto, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit);

    List<LocationDto> getLocationsShow(UserDto userDto, Integer locationLimit, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit);

    Integer newLocation(LocationIn location);

    Integer updateLocation(LocationIn location) throws WrongDataException;

    Integer deleteLocation(Integer lid);

    List<LocationDto> searchLocations(String search);
}
