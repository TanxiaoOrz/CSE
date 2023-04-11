package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Entity.Recommend.KeyAndType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Comparator;
import java.util.List;

@ApiModel(description = "地点的包装类,填充了基本信息，附加了从属的消息与信息类，排行分数，展示消息与展示信息类")
public class LocationDto  {

    @ApiModelProperty("唯一id标识")
    private Integer lid;//唯一标识
    @ApiModelProperty("地点名")
    private String name;
    @ApiModelProperty("地点简介")
    private String resume;
    @ApiModelProperty("简介消息的id")
    private Message basicMessage;
    @ApiModelProperty("所属地图的路径")
    private String mapBelong;
    @ApiModelProperty("图片的路径")
    private String imgHref;//所携带的图片
    @ApiModelProperty("横坐标的偏移量")
    private Integer x;//所在地图坐标
    @ApiModelProperty("纵坐标的偏移量")
    private Integer y;
    @ApiModelProperty("位于该地点的消息")
    private List<Message> messages;
    @ApiModelProperty("位于该地点的信息类")
    private List<InformationClass> informationClasses;
    @ApiModelProperty("要被排序展示的消息数组")
    private List<MessageDto> messageShows;
    @ApiModelProperty("要被排序展示的信息类数组")
    private List<InformationClassDto> informationShows;
    @ApiModelProperty("地点权能")
    private List<KeyAndType> keyAndTypes;
    @ApiModelProperty("排序分数")
    private Integer rankScore;
    @ApiModelProperty("是否被收藏，0否1是")
    private Integer isFavourite;

    public static class ScoreComparator implements Comparator<LocationDto> {
        @Override
        public int compare(LocationDto o1, LocationDto o2) {
            return o2.rankScore- o1.rankScore;
        }
    }


    public LocationDto() {

    }

    public LocationDto(Location location) {
        setLid(location.getLid());
        setImgHref(location.getImgHref());
        setName(location.getName());
        setResume(location.getResume());
        setMapBelong(location.getMapBelong());
        setX(location.getX());
        setY(location.getY());
    }

    public Integer getLid() {
        return lid;
    }

    public void setLid(Integer lid) {
        this.lid = lid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }


    public Message getBasicMessage() {
        return basicMessage;
    }

    public void setBasicMessage(Message basicMessage) {
        this.basicMessage = basicMessage;
    }

    public String getMapBelong() {
        return mapBelong;
    }

    public void setMapBelong(String mapBelong) {
        this.mapBelong = mapBelong;
    }

    public String getImgHref() {
        return imgHref;
    }

    public void setImgHref(String imgHref) {
        this.imgHref = imgHref;
    }

    public Integer getX() {
        return x;
    }

    public void setX(Integer x) {
        this.x = x;
    }

    public Integer getY() {
        return y;
    }

    public void setY(Integer y) {
        this.y = y;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    public List<InformationClass> getInformationClasses() {
        return informationClasses;
    }

    public void setInformationClasses(List<InformationClass> informationClasses) {
        this.informationClasses = informationClasses;
    }

    public List<MessageDto> getMessageShows() {
        return messageShows;
    }

    public void setMessageShows(List<MessageDto> messageShows) {
        this.messageShows = messageShows;
    }

    public List<InformationClassDto> getInformationShows() {
        return informationShows;
    }

    public void setInformationShows(List<InformationClassDto> informationShows) {
        this.informationShows = informationShows;
    }

    public Integer getRankScore() {
        return rankScore;
    }

    public void setRankScore(Integer rankScore) {
        this.rankScore = rankScore;
    }

    public List<KeyAndType> getKeyAndTypes() {
        return keyAndTypes;
    }

    public void setKeyAndTypes(List<KeyAndType> keyAndTypes) {
        this.keyAndTypes = keyAndTypes;
    }

    public Integer getIsFavourite() {
        return isFavourite;
    }

    public void setIsFavourite(Integer isFavourite) {
        this.isFavourite = isFavourite;
    }
}
