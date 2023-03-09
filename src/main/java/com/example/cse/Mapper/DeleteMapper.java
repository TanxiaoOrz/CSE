package com.example.cse.Mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeleteMapper {

    @Delete("delete from message where DeprecatedFlag = 1 or date_sub(now(),interval 1 week ) > OutTime")
    Integer deleteMessage();

    @Delete("delete from message_out where DeprecatedFlag = 1")
    Integer deleteOutMessage();

    @Delete("delete from information_class where DeprecatedFlag = 1")
    Integer deleteInformationClass();

    @Delete("delete from location where DeprecatedFlag = 1")
    Integer deleteLocation();

    @Delete("delete from calender where DeprecatedFlag = 1 or date_sub(now(),interval 3 month ) > Time")
    Integer deleteCalender();

}
