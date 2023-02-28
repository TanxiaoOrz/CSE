package com.example.cse.Mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SurfMapper {
    @Insert("insert into surf_message (Uid, Surf) VALUES (#{Uid},#{Mid})")
    Integer newMessageSurf(@Param("Uid") Integer uid,@Param("Mid") Integer mid);

    @Insert("insert into surf_information_class (Uid, Surf) VALUES (#{Uid},#{Cid})")
    Integer newInformationSurf(@Param("Uid") Integer uid,@Param("Cid") Integer cid);

    @Insert("insert into surf_message (Uid, Surf) VALUES (#{Uid},#{Lid})")
    Integer newLocationSurf(@Param("Uid") Integer uid,@Param("Lid") Integer lid);

    @Select("select avg(counts) from surf_count_message")
    Integer getAverageSurfCountMessage();

    @Select("select avg(counts) from surf_count_location")
    Integer getAverageSurfCountLocation();

    @Select("select avg(counts) from surf_count_information_class")
    Integer getAverageSurfCountInformationClass();

    @Select("select counts from surf_count_message where surf = #{surf}")
    Integer getSurfCountMessage(@Param("surf") Integer surf);

    @Select("select counts from surf_count_location where surf = #{surf}")
    Integer getSurfCountLocation(@Param("surf") Integer surf);

    @Select("select counts from surf_count_information_class where surf = #{surf}")
    Integer getSurfCountInformationClass(@Param("surf") Integer surf);
}
