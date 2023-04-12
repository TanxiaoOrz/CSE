package com.example.cse.Mapper;

import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Vo.FavouriteInformationClass;
import com.example.cse.Vo.FavouriteLocation;
import com.example.cse.Vo.FavouriteMessage;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FavouriteMapper {

    @Select("select `like` from favourite_message where Uid = #{Uid}")
    List<Integer> getFavouriteMidByUid(@Param("Uid") Integer Uid);

    @Select("select `like` from favourite_information_class where Uid = #{Uid}")
    List<Integer> getFavouriteCidByUid(@Param("Uid") Integer Uid);

    @Select("select `like` from favourite_location where Uid = #{Uid}")
    List<Integer> getFavouriteLidByUid(@Param("Uid") Integer Uid);

    @Select("select Mid,Title,favourite_message.Time from message, favourite_message where Uid = #{Uid} and `like` = message.Mid order by Time desc")
    List<FavouriteMessage> getFavouriteMessageByUser(@Param("Uid") Integer Uid);

    @Select("select Cid,Name,Time,Type from favourite_information_class,information_class where Uid = #{Uid} and Cid = favourite_information_class.like order by Time desc")
    List<FavouriteInformationClass> getFavouriteInformationClassByUser(@Param("Uid") Integer Uid);

    @Select("select Lid,Name,Time,ImgHref from favourite_location,location where Uid = #{Uid} and Lid = favourite_location.like order by Time desc")
    List<FavouriteLocation> getFavouriteLocationByUser(@Param("Uid") Integer Uid);

    @Insert("insert into favourite_message (Uid, `like`) VALUES (#{Uid},#{Mid})")
    Integer newFavouriteMessage(@Param("Uid") Integer Uid,@Param("Mid") Integer Mid);

    @Insert("insert into favourite_information_class (Uid, `like`) VALUES (#{Uid},#{Cid})")
    Integer newFavouriteInformationClass(@Param("Uid") Integer Uid,@Param("Cid") Integer Cid);

    @Insert("insert into favourite_location (Uid, `like`) VALUES (#{Uid},#{Lid})")
    Integer newFavouriteLocation(@Param("Uid") Integer Uid,@Param("Lid") Integer Lid);

    @Delete("delete from favourite_message where Uid = #{Uid} and `like`= #{Mid}")
    Integer deleteFavouriteMessage(@Param("Uid") Integer Uid,@Param("Mid") Integer Mid);

    @Delete("delete from favourite_information_class where Uid = #{Uid} and `like`= #{Cid}")
    Integer deleteFavouriteInformationClass(@Param("Uid") Integer Uid,@Param("Cid") Integer Cid);

    @Delete("delete from favourite_location where Uid = #{Uid} and `like`= #{Lid}")
    Integer deleteFavouriteLocation(@Param("Uid") Integer Uid,@Param("Mid") Integer Lid);

    @Delete("delete from favourite_message where Uid = #{Uid} and `like`is null")
    Integer deleteFavouriteMessageNull(@Param("Uid") Integer Uid);

    @Delete("delete from favourite_information_class where Uid = #{Uid} and `like`is null")
    Integer deleteFavouriteInformationClassNull(@Param("Uid") Integer Uid);

    @Delete("delete from favourite_location where Uid = #{Uid} and `like` is null")
    Integer deleteFavouriteLocationNull(@Param("Uid") Integer Uid);



}
