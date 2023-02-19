package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.InfCal;
import com.example.cse.Utils.Model;

import java.util.ArrayList;
import java.util.HashMap;

public class InformationClass{

    private Integer Cid;
    private Integer BasicMessage;//在类页面一定显示的描述性信息
    private String Resume;//简介
    private String Name;//名字
    private String Type;//类型
    private Integer Location;//所处未知

    public Integer getCid() {
        return Cid;
    }

    public void setCid(Integer cid) {
        Cid = cid;
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

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        Type = type;
    }

    public Integer getLocation() {
        return Location;
    }

    public void setLocation(Integer location) {
        Location = location;
    }
}
