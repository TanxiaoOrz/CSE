package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Message;
import org.apache.ibatis.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Mapper
public interface MessageMapper {

    List<Message> getMessageByRule(@Param("Mid") Integer mid, @Param("RelativeInformationClass") Integer cid, @Param("RelativeLocation") Integer lid);

    @Select("select * from message_out where Mid = #{Mid}")
    Message getMessageOut(@Param("Mid") Integer mid);

    Integer newMessage(Message message);

    Integer updateMessage(Message message);

    String getMessageClassType(@Param("Mid") Integer Mid);

    Integer newMessageRelationClass(@Param("Mid")Integer mid, @Param("Cid") Integer cid);

    Integer newMessageRelationLocation(@Param("Mid")Integer mid, @Param("Lid") Integer lid);

    @Delete("delete from message_information_class where Mid = #{Mid} and Cid = #{Cid}")
    Integer deleteMessageRelationClass(@Param("Mid")Integer mid, @Param("Cid") Integer cid);

    @Delete("delete from message_location where Mid = #{Mid} and Lid = #{Lid}")
    Integer deleteMessageRelationLocation(@Param("Mid")Integer mid, @Param("Lid") Integer lid);

    @Select("select Cid from message_information_class where Mid =#{Mid}")
    List<Integer> getMessageRelationCid(@Param("Mid") Integer mid);

    @Select("select Lid from message_location where Mid =#{Mid}")
    List<Integer> getMessageRelationLid(@Param("Mid") Integer mid);

    @Update("update message set DeprecatedFlag = 1 where Mid = #{Mid};")
    Integer deleteMessage(@Param("Mid") Integer mid);

    List<Message> searchMessage(@Param("Defaults")List<String> defaults,
                                @Param("Adds")List<String> adds,
                                @Param("Minuses")List<String> minuses);

    List<Message> searchMessageOut(@Param("Defaults")List<String> defaults,
                                    @Param("Adds")List<String> adds,
                                    @Param("Minuses")List<String> minuses);

}
