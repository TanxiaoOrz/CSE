package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Message;
import org.springframework.util.StringUtils;

import java.util.List;

public class MessageIn extends Message {
    List<Integer> locations;
    List<Integer> informationClasses;

    public List<Integer> getLocations() {
        return locations;
    }

    public void setLocations(List<Integer> locations) {
        this.locations = locations;
    }

    public List<Integer> getInformationClasses() {
        return informationClasses;
    }

    public void setInformationClasses(List<Integer> informationClasses) {
        this.informationClasses = informationClasses;
    }

    public boolean checkUpdate(Message message) {
        if (StringUtils.hasText(getMessage())) {
            setMessage(message.getMessage());
        }
        if (getTime() == null) {
            setTime(message.getTime());
        }
        if (StringUtils.hasText(getTitle())) {
            setTitle(message.getTitle());
        }
        if (StringUtils.hasText(getResume())) {
            setResume(message.getResume());
        }
        if (getReleaseTime() == null) {
            setReleaseTime(message.getReleaseTime());
        }
        if (getOutTime() == null) {
            setOutTime(message.getOutTime());
        }

        return equals(message);

    }
}
