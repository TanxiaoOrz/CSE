package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.InformationClass;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface InformationClassMapper {

    List<InformationClass> getInformationClassByRule(@Param("Cid") Integer cid, @Param("RelativeMessage") Integer relativeMessage,@Param("RelativeLocation") Integer lid);

    Integer newInformationClass(InformationClass informationClass);

    Integer updateInformationClass(InformationClass informationClass);

    @Update("update information_class set DeprecatedFlag = 1 where Cid = #{Cid}")
    Integer deleteInformationClass(@Param("Cid") Integer cid);

    List<InformationClass> searchInformationClass(@Param("Type")String type,
                                                  @Param("Defaults")List<String> defaults,
                                                  @Param("Adds")List<String> adds,
                                                  @Param("Minuses")List<String> minuses);

}
