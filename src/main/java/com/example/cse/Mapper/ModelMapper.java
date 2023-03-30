package com.example.cse.Mapper;

import com.example.cse.Dto.BasicModelDto;
import com.example.cse.Dto.ModelDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface ModelMapper {

    @Select("SELECT * from basic_model where Bid in (SELECT Bid from year_basic_model where Year = #{Year})")
    List<ModelDto> getModelByYear(@Param("Year")Integer year);

    @Select("SELECT * from basic_model where Bid in (SELECT Bid from profession_basic_model where Pid = #{Pid})")
    List<ModelDto> getModelByProfession(@Param("Pid")Integer pid);

    @Select("SELECT * from basic_model where Bid in (SELECT Bid from profession_basic_model where Pid = #{Pid})")
    List<BasicModelDto> getBasicModelByProfession(@Param("Pid")Integer pid);

    @Select("SELECT * from basic_model where Bid in (SELECT Bid from year_basic_model where Year = #{Year})")
    List<BasicModelDto> getBasicModelByYear(@Param("Year")Integer year);

    @Update("update basic_model set score = #{score} where Bid = #{bid}")
    Integer updateBasicModels(BasicModelDto basicModelDto);
}
