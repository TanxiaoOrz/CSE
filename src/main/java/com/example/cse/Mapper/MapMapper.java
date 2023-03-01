package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper
public interface MapMapper {
    @Select("select * from map where Mid = #{Mid}")
    Map getMapByMid(@Param("Mid") Integer mid);
}
