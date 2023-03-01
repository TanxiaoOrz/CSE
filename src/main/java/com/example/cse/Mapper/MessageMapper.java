package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Message;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Mapper
public interface MessageMapper {

    List<Message> getMessageByRule(@Param("Mid") Integer mid, @Param("RelativeInformationClass") Integer cid, @Param("RelativeLocation") Integer lid);

    Integer newMessage(Message message);

    Integer updateMessage(Message message);

    String getMessageClassType(@Param("Mid") Integer Mid);


}
