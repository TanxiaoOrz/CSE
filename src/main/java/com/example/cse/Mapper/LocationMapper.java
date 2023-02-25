package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LocationMapper {

    Location getLocationByRule(@Param("Lid") Integer lid);

    Integer newLocation(Location location);

    Integer updateLocation(Location location);
}
