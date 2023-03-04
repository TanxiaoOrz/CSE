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
        boolean equal = true;
        if (StringUtils.hasText(getMessage())) {
            setMessage(message.getMessage());
            equal = false;
        }
        if (getTime() == null) {
            setTime(message.getTime());
            equal = false;
        }
        if (StringUtils.hasText(getTitle())) {
            setTitle(message.getTitle());
            equal = false;
        }
        if (StringUtils.hasText(getResume())) {
            setResume(message.getResume());
            equal = false;
        }
        if (getReleaseTime() == null) {
            setReleaseTime(message.getReleaseTime());
            equal = false;
        }
        if (getOutTime() == null) {
            setOutTime(message.getOutTime());
            equal = false;
        }

        return equal && equals(message);

    }
}
