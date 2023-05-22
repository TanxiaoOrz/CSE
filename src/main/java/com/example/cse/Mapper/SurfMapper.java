package com.example.cse.Mapper;

import com.example.cse.Dto.SurfCounts;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SurfMapper {
    @Insert("insert into surf_message (Uid, Surf) VALUES (#{Uid},#{Mid})")
    Integer newMessageSurf(@Param("Uid") Integer uid,@Param("Mid") Integer mid);

    @Insert("insert into surf_information_class (Uid, Surf) VALUES (#{Uid},#{Cid})")
    Integer newInformationSurf(@Param("Uid") Integer uid,@Param("Cid") Integer cid);

    @Insert("insert into surf_location (Uid, Surf) VALUES (#{Uid},#{Lid})")
    Integer newLocationSurf(@Param("Uid") Integer uid,@Param("Lid") Integer lid);

    @Select("select avg(counts) from surf_count_message")
    Float getAverageSurfCountMessage();

    @Select("select avg(counts) from surf_count_location")
    Float getAverageSurfCountLocation();

    @Select("select avg(counts) from surf_count_information_class")
    Float getAverageSurfCountInformationClass();

    @Select("select counts from surf_count_message where surf = #{surf}")
    Integer getSurfCountMessage(@Param("surf") Integer surf);

    @Select("select counts from surf_count_location where surf = #{surf}")
    Integer getSurfCountLocation(@Param("surf") Integer surf);

    @Select("select counts from surf_count_information_class where surf = #{surf}")
    Integer getSurfCountInformationClass(@Param("surf") Integer surf);

    @Select("select Surf from surf_message where Uid = #{Uid} and Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 5 ")
    List<Integer> getSurfMostMessages(@Param("Uid")Integer uid);

    @Select("select Surf from surf_information_class where Uid = #{Uid} and Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 5")
    List<Integer> getSurfMostInformationClasses(@Param("Uid")Integer uid);

    @Select("select Surf from surf_location where Uid = #{Uid} and Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 5")
    List<Integer> getSurfMostLocations(@Param("Uid")Integer uid);


    @Select("select Surf as id,count(Surf) as counts  from surf_information_class where Uid = #{Uid} and Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 10")
    List<SurfCounts> getSurfMostInformationClassesCounts(@Param("Uid")Integer uid);

    @Select("select Surf as id,count(Surf) as counts  from surf_location where Uid = #{Uid} and Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 10")
    List<SurfCounts> getSurfMostLocationsCounts(@Param("Uid")Integer uid);

    @Select("select x.Kid as id,count(Surf) as counts  from surf_information_class,information_class_key as x where Surf in (select cid from information_class_key as link where link.Kid = x.kid) and Uid = #{Uid} and Time > date_sub(now(),interval 1 year) group by x.kid")
    List<SurfCounts> getSurfMostKeysCounts(@Param("Uid")Integer uid);

    @Select("select Surf as id,count(Surf) as counts  from surf_information_class where Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 5")
    List<SurfCounts> getSurfMostInformationClassesCountsAll();

    @Select("select Surf as id,count(Surf) as counts  from surf_location where Time > date_sub(now(),interval 1 year) group by Surf order by count(Surf) desc limit 5")
    List<SurfCounts> getSurfMostLocationsCountsAll();

    @Select("select x.Kid as id,count(Surf) as counts  from surf_information_class,information_class_key as x where Surf in (select cid from information_class_key as link where link.Kid = x.kid) and Time > date_sub(now(),interval 1 year) group by x.kid")
    List<SurfCounts> getSurfMostKeysCountsAll();


    Integer getCountKeyByUser(@Param("Uids") List<Integer> uids,@Param("Kid") Integer kid);
}
