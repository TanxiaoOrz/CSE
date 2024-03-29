package com.example.cse.Entity.InformationClass;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;
import java.util.Objects;

@ApiModel(description = "消息的存储实体类,没有任何包装")
public class Message{
    @ApiModelProperty("唯一消息标识号")
    private Integer mid;//唯一消息标识号
    @ApiModelProperty("需要占用的时间,也是json字符串数组，后端不作解析，前端自己解析自己生成")
    private String time;//需要占用的时间
    @ApiModelProperty("消息标题")
    private String title;//消息标题
    @ApiModelProperty("消息简介")
    private String resume;//消息简介
    @ApiModelProperty(value = "消息本体,json字符串包含file数组内部是附件路径，image数组内部时携带的图片路径，message消息字符串",example = "{\"file\": [], \"image\": [], \"message\": \"\"}")
    private String message;//消息本体
    @ApiModelProperty("消息放出时间")
    private Date releaseTime;//消息放出时间
    @ApiModelProperty("消息过期时间")
    private Date outTime;//消息过期时间

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
    }

    public Date getOutTime() {
        return outTime;
    }

    public void setOutTime(Date outTime) {
        this.outTime = outTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Message message1 = (Message) o;
        return mid.equals(message1.mid) && Objects.equals(time, message1.time) && Objects.equals(title, message1.title) && Objects.equals(resume, message1.resume) && Objects.equals(message, message1.message) && Objects.equals(releaseTime, message1.releaseTime) && Objects.equals(outTime, message1.outTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(mid, time, title, resume, message, releaseTime, outTime);
    }
}
