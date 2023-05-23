package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.Message;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

import java.util.List;

@ApiModel(description = "消息的传入类附带地点与信息类的id")
public class MessageIn extends Message {
    @ApiModelProperty("消息所涉及的地点列表，此处需要的它们的id数组")
    List<Integer> locations;
    @ApiModelProperty("消息所从属的信息类列表，此处需要的它们的id数组")
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
        if (!StringUtils.hasText(getMessage())) {
            setMessage(message.getMessage());
        }
        if (getTime() == null) {
            setTime(message.getTime());
        }
        if (!StringUtils.hasText(getTitle())) {
            setTitle(message.getTitle());
        }
        if (!StringUtils.hasText(getResume())) {
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
