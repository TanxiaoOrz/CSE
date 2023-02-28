package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Vo.KeyAndType;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

public class InformationClassDto {

    public static class ScoreComparator implements Comparator<InformationClassDto> {
        @Override
        public int compare(InformationClassDto o1, InformationClassDto o2) {
            return o2.rankScore - o1.rankScore;
        }
    }

    private Integer cid;
    private String resume;//简介
    private String name;//名字
    private String type;//类型
    private String imgHref;//图片

    private Message basicMessage;

    private List<Message> messages;
    private Location location;

    private List<KeyAndType> keyAndTypes;

    private List<MessageDto> showMessages;

    private Integer rankScore;

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

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
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

    public void setRankScore(HashMap<Integer, Integer> keywordModels,HashMap<Integer, Integer> informationClassModel,Integer surfScore) {
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
}