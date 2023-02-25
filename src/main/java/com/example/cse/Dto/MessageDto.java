package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Message;

import java.util.Date;
import java.util.List;

public class MessageDto extends Message {
    public MessageDto() {
    }

    public MessageDto(Message message,InformationClass relationInformationClass) {
        setMid(message.getMid());
        setMessage(message.getMessage());
        setOutTime(message.getOutTime());
        setResume(message.getResume());
        setReleaseTime(message.getReleaseTime());
        setTitle(message.getTitle());
        setVisual(message.getVisual());
        this.relationInformationClass = relationInformationClass;
    }

    InformationClass relationInformationClass;

    public InformationClass getRelationInformationClass() {
        return relationInformationClass;
    }

    public void setRelationInformationClass(InformationClass relationInformationClass) {
        this.relationInformationClass = relationInformationClass;
    }
}
