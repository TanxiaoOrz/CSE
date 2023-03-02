package com.example.cse.Service;

import com.example.cse.Dto.LocationDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;

import java.util.List;

public interface LocationService {
    LocationDto getLocation(Integer lid, UserDto userDto, Integer informationLimit, Integer messageLimit, Integer informationMessageLimit);

    List<LocationDto> getLocations(UserDto userDto);

    Integer newLocation(Location location);

    Integer updateLocation(Location location);
}
