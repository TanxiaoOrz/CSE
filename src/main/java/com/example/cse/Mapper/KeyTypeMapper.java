package com.example.cse.Mapper;

import com.example.cse.Vo.KeyAndType;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface KeyTypeMapper {

    @Select("select keyword.Kid, keyword.KeyResume, keyword.KeyName, TypeName,TypeResume from information_class_key,keyword,keyword_type where Cid = #{Cid} and keyword.Kid = information_class_key.Kid and keyword.KeywordType = keyword_type.Tid")
    List<KeyAndType> getKeyAndTypeByCid(@Param("Cid")Integer Cid);

    @Insert("insert into information_class_key (Cid, Kid) VALUES (#{Cid}, #{Kid})")
    Integer newKeyAndTypeLink(@Param("Cid")Integer cid,@Param("Kid")Integer kid);

    @Delete("delete from information_class_key where Cid = #{Cid} and Kid = #{Kid}")
    Integer deleteKeyAndTypeLink(@Param("Cid")Integer cid,@Param("Kid")Integer kid);

    @Select("select Kid from information_class_key where Cid = #{Cid}")
    List<Integer> getKidsByCid(@Param("Cid")Integer Cid);

}
