package com.example.cse.Mapper;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Vo.ProfessionIn;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProfessionMapper {

    Integer checkProfessionExist(@Param("Pid") Integer Pid, @Param("ProfessionName") String ProfessionName);

    Integer newProfession(ProfessionIn profession);

    List<Profession> getProfessionAll();

    Profession getProfessionByPid(@Param("Pid") Integer Pid);

}
