package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LocationMapper {

    Location getLocationByRule(Location location);

    Integer newLocation(Location location);

    Integer updateLocation(Location location);
}
