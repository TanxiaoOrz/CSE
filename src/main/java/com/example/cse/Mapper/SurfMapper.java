package com.example.cse.Mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SurfMapper {
    @Insert("insert into surf_message (Uid, Surf) VALUES (#{Uid},#{Mid})")
    Integer newMessageSurf(@Param("Uid") Integer uid,@Param("Mid") Integer mid);

    @Insert("insert into surf_information_class (Uid, Surf) VALUES (#{Uid},#{Cid})")
    Integer newInformationSurf(@Param("Uid") Integer uid,@Param("Cid") Integer cid);

    @Insert("insert into surf_message (Uid, Surf) VALUES (#{Uid},#{Lid})")
    Integer newLocationSurf(@Param("Uid") Integer uid,@Param("Lid") Integer lid);
}
