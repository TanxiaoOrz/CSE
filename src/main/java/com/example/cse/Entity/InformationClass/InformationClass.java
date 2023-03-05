package com.example.cse.Entity.InformationClass;

import java.util.Objects;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InformationClass that = (InformationClass) o;
        return cid.equals(that.cid) && Objects.equals(basicMessage, that.basicMessage) && Objects.equals(resume, that.resume) && Objects.equals(name, that.name) && Objects.equals(type, that.type) && Objects.equals(imgHref, that.imgHref) && Objects.equals(location, that.location);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cid, basicMessage, resume, name, type, imgHref, location);
    }

    public boolean checkUpdate(InformationClass informationClass) {
        boolean update = true;
        if (informationClass.getLocation() != null) {
            update = location.equals(informationClass.getLocation());
        }
        if (informationClass.getBasicMessage() != null) {
            update = basicMessage.equals(informationClass.basicMessage);
        }
        if (informationClass.getName() != null) {
            update = name.equals(informationClass.getName());
        }
        if (informationClass.getResume() != null) {
            update = resume.equals(informationClass.resume);
        }
        if (informationClass.getType() != null) {
            update = type.equals(informationClass.type);
        }
        if (informationClass.getImgHref() != null) {
            update = imgHref.equals(informationClass.imgHref);
        }
        return update;
    }
}
