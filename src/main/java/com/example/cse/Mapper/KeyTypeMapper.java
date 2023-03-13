package com.example.cse.Mapper;

import com.example.cse.Entity.Recommend.KeyAndType;
import com.example.cse.Entity.Recommend.KeyWord;
import com.example.cse.Entity.Recommend.KeyWordType;
import com.example.cse.Entity.Recommend.TypeWithKey;
import org.apache.ibatis.annotations.*;
import sun.security.rsa.RSAUtil;

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

    @Insert("insert into keyword (KeyName, KeywordType, KeyResume) VALUES (#{KeyName}, #{KeywordType}, #{KeyResume})")
    Integer newKeyword(KeyWord keyWord);

    @Insert("insert into keyword_type (TypeName, TypeResume) VALUES (#{TypeName}, #{TypeResume})")
    Integer newKeywordType(KeyWordType keyWordType);

    @Select("select * from keyword_type")
    List<TypeWithKey> getAllType();

    @Select("select Kid from keyword where KeywordType = #{Tid}")
    List<KeyWord> getKeysByTid(@Param("Tid")Integer tid);

}
