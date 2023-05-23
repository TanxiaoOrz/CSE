package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Comparator;
import java.util.Date;
import java.util.List;

@ApiModel(description = "消息的包装类,附带了地点与信息类和分数")
public class MessageDto extends Message {

    public static class ScoreComparator implements Comparator<MessageDto> {
        @Override
        public int compare(MessageDto o1, MessageDto o2) {
            return o2.rankScore - o1.rankScore;
        }
    }

    @ApiModelProperty("是否被收藏，0否1是")
    private Integer isFavourite;

    @ApiModelProperty("评价分数，排序使用")
    private Integer rankScore;

    @ApiModelProperty("消息所涉及的地点列表")
    private List<Location> locations;

    @ApiModelProperty("消息所从属的信息类列表")
    private List<InformationClass> relationInformationClass;

    public MessageDto() {
    }

    public MessageDto(Message message) {
        setMid(message.getMid());
        setMessage(message.getMessage());
        setOutTime(message.getOutTime());
        setResume(message.getResume());
        setReleaseTime(message.getReleaseTime());
        setTitle(message.getTitle());
        setTime(message.getTime());
    }

    public void setRankScore(Integer timeScore, Integer userScore, Integer surfScore, Integer outTimeScore) {
        if (userScore == null) {
            userScore = 0;
        }
        rankScore = timeScore + userScore + surfScore;
        if (getOutTime().compareTo(new Date()) >= 0) // 过期扣分
            rankScore -= outTimeScore;
    }

    public Integer getIsFavourite() {
        return isFavourite;
    }

    public void setIsFavourite(Integer isFavourite) {
        this.isFavourite = isFavourite;
    }

    public Integer getRankScore() {
        return rankScore;
    }

    public void setRankScore(Integer rankScore) {
        this.rankScore = rankScore;
    }

    public List<Location> getLocations() {
        return locations;
    }

    public void setLocations(List<Location> locations) {
        this.locations = locations;
    }

    public List<InformationClass> getRelationInformationClass() {
        return relationInformationClass;
    }

    public void setRelationInformationClass(List<InformationClass> relationInformationClass) {
        this.relationInformationClass = relationInformationClass;
    }
}
