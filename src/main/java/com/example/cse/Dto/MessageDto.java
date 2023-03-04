package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;

import java.util.Comparator;
import java.util.Date;
import java.util.List;

public class MessageDto extends Message{

    public static class ScoreComparator implements Comparator<MessageDto> {
        @Override
        public int compare(MessageDto o1, MessageDto o2) {
            return o2.rankScore - o1.rankScore;
        }
    }

    private Integer rankScore;

    private List<Location> locations;

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


    public void setRankScore(Integer timeScore, Integer userScore,Integer surfScore, Integer outTimeScore) {
        if (userScore == null) {
            userScore = 0;
        }
        rankScore = timeScore + userScore + surfScore;
        if (getOutTime().compareTo(new Date()) >= 0) //过期扣分
            rankScore -= outTimeScore;
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
