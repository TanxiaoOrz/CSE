package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.Message;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(description = "返回各个类型的消息最新15条")
public class LatestMessages {
    @ApiModelProperty("活动类的消息")
    List<Message> activities;
    @ApiModelProperty("比赛类的消息")
    List<Message> contests;
    @ApiModelProperty("部门类的消息")
    List<Message> sections;
    @ApiModelProperty("资源类的消息")
    List<Message> resources;
    public void setActivities(List<Message> activities) {
        this.activities = activities;
    }

    public List<Message> getContests() {
        return contests;
    }

    public void setContests(List<Message> contests) {
        this.contests = contests;
    }

    public List<Message> getSections() {
        return sections;
    }

    public void setSections(List<Message> sections) {
        this.sections = sections;
    }

    public List<Message> getResources() {
        return resources;
    }

    public void setResources(List<Message> resources) {
        this.resources = resources;
    }

    public List<Message> getActivities() {
        return activities;
    }
}
