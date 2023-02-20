package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.Calender;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CalenderMapper {

    @Select("SELECT * from calender where Uid = #{Uid} and DeprecatedFlag = 0 and Time < NOW() order by Time desc")
    List<Calender> getCalenderByUserBefore(@Param("Uid") Integer uid);

    @Select("SELECT * from calender where Uid = #{Uid} and DeprecatedFlag = 0 and Time >= NOW() order by Time")
    List<Calender> getCalenderByUserAfter(@Param("Uid") Integer uid);

    @Update("update calender set Description = #{Description} where Time =#{Time} and Uid = #{Uid} and DeprecatedFlag = 0")
    Integer updateCalenderDescription(Calender calender);

    @Insert("insert into calender (Uid, Time, Description, RelationFunction) VALUES (#{Uid}, #{Time}, #{Description}, #{RelationFunction})")
    Integer newCalender(Calender calender);

    @Update("update calender set DeprecatedFlag = #{DeprecatedFlag} where Time =#{Time} and Uid = #{Uid} and DeprecatedFlag = 0")
    Integer updateCalenderDeprecated(Calender calender);

}
