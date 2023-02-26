package com.example.cse.Entity.InformationClass;

public class InformationClass{

    private Integer cid;
    private Integer basicMessage;//在类页面一定显示的描述性信息
    private String resume;//简介
    private String name;//名字
    private String type;//类型
    private String imgHref;//图片
    private Integer location;//所处未知

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getBasicMessage() {
        return basicMessage;
    }

    public void setBasicMessage(Integer basicMessage) {
        this.basicMessage = basicMessage;
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

    public Integer getLocation() {
        return location;
    }

    public void setLocation(Integer location) {
        this.location = location;
    }
}
