package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Location;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LocationMapper {

    List<Location> getLocationByRule(@Param("Lid") Integer lid);

    Integer newLocation(Location location);

    Integer updateLocation(Location location);
}
