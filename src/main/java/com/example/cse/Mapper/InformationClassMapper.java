package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.InformationClass;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InformationClassMapper {

    InformationClass getInformationClassByRule(InformationClass informationClass);

    Integer newInformationClass(InformationClass informationClass);

    Integer updateInformationClass(InformationClass informationClass);

}
