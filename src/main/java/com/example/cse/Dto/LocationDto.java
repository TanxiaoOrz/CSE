package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Map;
import com.example.cse.Entity.InformationClass.Message;

import java.util.Comparator;
import java.util.List;

public class LocationDto  {

    private Integer Lid;//唯一标识
    private String Name;
    private String Resume;
    private String Ability;
    private Message BasicMessage;



    private Map MapBelong;
    private Map MapOwn;
    private String imgHref;//所携带的图片
    private Integer X;//所在地图坐标
    private Integer Y;

    private List<Message> messages;
    private List<InformationClass> informationClasses;
    private List<MessageDto> messageShows;
    private List<InformationClassDto> informationShows;

    private Integer rankScore;

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
        setAbility(location.getAbility());
        setImgHref(location.getImgHref());
        setName(location.getName());
        setResume(location.getResume());
    }

    public Integer getLid() {
        return Lid;
    }

    public void setLid(Integer lid) {
        Lid = lid;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getResume() {
        return Resume;
    }

    public void setResume(String resume) {
        Resume = resume;
    }

    public String getAbility() {
        return Ability;
    }

    public void setAbility(String ability) {
        Ability = ability;
    }

    public Message getBasicMessage() {
        return BasicMessage;
    }

    public void setBasicMessage(Message basicMessage) {
        BasicMessage = basicMessage;
    }

    public Map getMapBelong() {
        return MapBelong;
    }

    public void setMapBelong(Map mapBelong) {
        MapBelong = mapBelong;
    }

    public Map getMapOwn() {
        return MapOwn;
    }

    public void setMapOwn(Map mapOwn) {
        MapOwn = mapOwn;
    }

    public String getImgHref() {
        return imgHref;
    }

    public void setImgHref(String imgHref) {
        this.imgHref = imgHref;
    }

    public Integer getX() {
        return X;
    }

    public void setX(Integer x) {
        X = x;
    }

    public Integer getY() {
        return Y;
    }

    public void setY(Integer y) {
        Y = y;
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
}
