package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Vo.ProfessionIn;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProfessionMapper {

    Integer checkProfessionExist(@Param("Pid") Integer Pid, @Param("ProfessionName") String ProfessionName);

    Integer newProfession(ProfessionIn profession);

    List<Profession> getProfessionAll();

    @Select("SELECT Pid from profession")
    List<Integer> getPidAll();

    Profession getProfessionByPid(@Param("Pid") Integer Pid);

}
