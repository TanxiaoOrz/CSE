package com.example.cse.Entity.InformationClass;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

import java.util.Objects;

@ApiModel(description = "信息类的实体类，没有任何包装的版本")
public class InformationClass{

    @ApiModelProperty("唯一编号")
    private Integer cid;
    @ApiModelProperty("描述该信息类的简介消息的id")
    private Integer basicMessage;//在类页面一定显示的描述性信息
    @ApiModelProperty("简介")
    private String resume;//简介
    @ApiModelProperty("信息类名字")
    private String name;//名字
    @ApiModelProperty(value = "类型",allowableValues = "比赛,部门,活动,资源")
    private String type;//类型
    @ApiModelProperty("图片的路径")
    private String imgHref;//图片


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


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InformationClass that = (InformationClass) o;
        return cid.equals(that.cid) && Objects.equals(basicMessage, that.basicMessage) && Objects.equals(resume, that.resume) && Objects.equals(name, that.name) && Objects.equals(type, that.type) && Objects.equals(imgHref, that.imgHref);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cid, basicMessage, resume, name, type, imgHref);
    }

    public boolean checkUpdate(InformationClass informationClass) {
        boolean update = true;
        if (basicMessage != null) {
            update &= basicMessage.equals(informationClass.basicMessage);
        }
        if (name != null) {
            update &= name.equals(informationClass.getName());
        }
        if (resume != null) {
            update &= resume.equals(informationClass.resume);
        }
        if (type != null) {
            update &= type.equals(informationClass.type);
        }
        if (imgHref != null) {
            update &= imgHref.equals(informationClass.imgHref);
        }
        return update;
    }

    public void setZeroToNull() {
        if (basicMessage !=null && basicMessage == 0) {
            basicMessage = null;
        }
        if (!StringUtils.hasText(type)) {
            type = null;
        }
        if (!StringUtils.hasText(name)) {
            name = null;
        }if (!StringUtils.hasText(resume)) {
            resume = null;
        }
        if (!StringUtils.hasText(imgHref)) {
            imgHref = null;
        }

    }
}
