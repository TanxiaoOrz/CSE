package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.KeyWord;

public class Location {
    private Integer Lid;//唯一标识
    private String Name;
    private String Resume;
    private String Ability;
    private Integer BasicMessage;



    private Integer MapBelong;
    private Integer MapOwn;
    private String imgHref;//所携带的图片
    private Integer X;//所在地图坐标
    private Integer Y;

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
    public Integer getBasicMessage() {
        return BasicMessage;
    }

    public void setBasicMessage(Integer basicMessage) {
        BasicMessage = basicMessage;
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

    public Integer getMapBelong() {
        return MapBelong;
    }

    public void setMapBelong(Integer mapBelong) {
        MapBelong = mapBelong;
    }

    public Integer getMapOwn() {
        return MapOwn;
    }

    public void setMapOwn(Integer mapOwn) {
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
}
