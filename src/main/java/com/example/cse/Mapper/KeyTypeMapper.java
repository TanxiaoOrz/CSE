package com.example.cse.Mapper;

import com.example.cse.Vo.KeyAndType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface KeyTypeMapper {

    @Select("select keyword.KeyResume, keyword.KeyName, TypeName,TypeResume from information_class_key,keyword,keyword_type where Cid = #{Cid} and keyword.Kid = information_class_key.Kid and keyword.KeywordType = keyword_type.Tid")
    List<KeyAndType> getKeyAndTypeByCid(@Param("Cid")Integer Cid);

}
