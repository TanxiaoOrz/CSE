package com.example.cse.Entity.InformationClass;

import java.util.Date;

public class Message{
    private Integer Mid;//唯一消息标识号
    private String Visual;//可视化格式
    private String Title;//消息标题
    private String Resume;//消息简介
    private String Message;//消息本体
    private Date ReleaseTime;//消息放出时间
    private Date OutTime;//消息过期时间

    public Integer getMid() {
        return Mid;
    }

    public void setMid(Integer mid) {
        Mid = mid;
    }

    public String getVisual() {
        return Visual;
    }

    public void setVisual(String visual) {
        Visual = visual;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public String getResume() {
        return Resume;
    }

    public void setResume(String resume) {
        Resume = resume;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String message) {
        Message = message;
    }

    public Date getReleaseTime() {
        return ReleaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        ReleaseTime = releaseTime;
    }

    public Date getOutTime() {
        return OutTime;
    }

    public void setOutTime(Date outTime) {
        OutTime = outTime;
    }
}
