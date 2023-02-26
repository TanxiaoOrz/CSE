package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Vo.KeyAndType;

import java.util.List;

public class InformationClassDto {

    private Integer cid;
    private String resume;//简介
    private String name;//名字
    private String type;//类型
    private String imgHref;//图片

    private Message basicMessage;

    private List<Message> messages;
    private Location location;

    private List<KeyAndType> keyAndTypes;

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

    public InformationClassDto(InformationClass informationClass) {
        cid= informationClass.getCid();
        resume = informationClass.getResume();
        name = informationClass.getName();
        type = informationClass.getType();
        imgHref = informationClass.getImgHref();
    }
}