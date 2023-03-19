package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Location;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface LocationMapper {

    List<Location> getLocationByRule(@Param("Lid") Integer lid,@Param("RelativeMessage")Integer mid);

    Integer newLocation(Location location);

    Integer updateLocation(Location location);

    @Update("update location set DeprecatedFlag = 1 where Lid = #{Lid}")
    Integer deleteLocation(@Param("Lid") Integer lid);

    List<Location> searchLocation(@Param("Defaults")List<String> defaults,
                                  @Param("Adds")List<String> adds,
                                  @Param("Minuses")List<String> minuses);

    @Select("select * from location where Lid in (select Lid from information_class_location where Cid = #{Cid})")
    List<Location> getLocationByCid(@Param("Cid") Integer cid);

    @Select("select Lid from location where Lid in (select Lid from information_class_location where Cid = #{Cid})")
    List<Integer> getLidByCid(@Param("Cid") Integer cid);
}
