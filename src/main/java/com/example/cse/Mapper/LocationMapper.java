package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Location;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface LocationMapper {

    List<Location> getLocationByRule(@Param("Lid") Integer lid,@Param("RelativeMessage")Integer mid);

    Integer newLocation(Location location);

    Integer updateLocation(Location location);

    @Update("update location set DeprecatedFlag = 1 where Lid = #{Lid}")
    Integer deleteLocation(@Param("Lid") Integer lid);
}
