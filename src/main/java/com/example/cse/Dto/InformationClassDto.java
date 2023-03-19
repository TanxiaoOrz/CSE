package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Entity.Recommend.KeyAndType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Comparator;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@ApiModel(description = "信息类的包装类,附带了地点与从属信息和要展示的信息以及关键词和分数")
public class InformationClassDto {

    public static class ScoreComparator implements Comparator<InformationClassDto> {
        @Override
        public int compare(InformationClassDto o1, InformationClassDto o2) {
            return o2.rankScore - o1.rankScore;
        }
    }

    @ApiModelProperty("唯一编号")
    private Integer cid;
    @ApiModelProperty("简介")
    private String resume;//简介
    @ApiModelProperty("信息类名字")
    private String name;//名字
    @ApiModelProperty(value = "类型",allowableValues = "比赛,部门,活动,资源")
    private String type;//类型
    @ApiModelProperty("图片的路径")
    private String imgHref;//图片

    @ApiModelProperty("描述该信息类的简介消息的id")
    private Message basicMessage;

    @ApiModelProperty("从属于该类的消息")
    private List<Message> messages;
    @ApiModelProperty("所在位置")
    private List<Location> location;

    @ApiModelProperty("附属的关键词")
    private List<KeyAndType> keyAndTypes;
    @ApiModelProperty("要被排序展示的消息数组")
    private List<MessageDto> showMessages;
    @ApiModelProperty("排序分数")
    private Integer rankScore;
    @ApiModelProperty("是否被收藏，0否1是")
    private Integer isFavourite;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getImgHref() {
        return imgHref;
    }

    public void setImgHref(String imgHref) {
        this.imgHref = imgHref;
    }

    public Message getBasicMessage() {
        return basicMessage;
    }

    public void setBasicMessage(Message basicMessage) {
        this.basicMessage = basicMessage;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    public List<Location> getLocation() {
        return location;
    }

    public void setLocation(List<Location> location) {
        this.location = location;
    }

    public List<KeyAndType> getKeyAndTypes() {
        return keyAndTypes;
    }

    public void setKeyAndTypes(List<KeyAndType> keyAndTypes) {
        this.keyAndTypes = keyAndTypes;
    }

    public List<MessageDto> getShowMessages() {
        return showMessages;
    }

    public void setShowMessages(List<MessageDto> showMessage) {
        this.showMessages = showMessage;
    }

    public Integer getRankScore() {
        return rankScore;
    }

    public void setRankScore(Integer rankScore) {
        this.rankScore = rankScore;
    }

    public void setRankScore(ConcurrentHashMap<Integer, Integer> keywordModels, ConcurrentHashMap<Integer, Integer> informationClassModel, Integer surfScore) {
        int keyScore = 0;
        for (KeyAndType keyAndType:keyAndTypes) {
            Integer score = keywordModels.get(keyAndType.getKid());
            keyScore += score!=null? score : 0;
        }
        Integer classScore =informationClassModel.get(cid);
        if (classScore == null) {
            classScore=0;
        }
        this.rankScore = keyScore + surfScore + classScore;
    }

    public InformationClassDto(InformationClass informationClass) {
        cid= informationClass.getCid();
        resume = informationClass.getResume();
        name = informationClass.getName();
        type = informationClass.getType();
        imgHref = informationClass.getImgHref();
    }

    public Integer getIsFavourite() {
        return isFavourite;
    }

    public void setIsFavourite(Integer isFavourite) {
        this.isFavourite = isFavourite;
    }
}