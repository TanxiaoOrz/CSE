package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.InformationClass;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface InformationClassMapper {

    InformationClass getInformationClassByRule(@Param("Cid") Integer cid,@Param("RelativeMessage") Integer relativeMessage);

    Integer newInformationClass(InformationClass informationClass);

    Integer updateInformationClass(InformationClass informationClass);

}
