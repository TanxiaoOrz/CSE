package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(value = "用户喜欢列表结构体")
public class FavouriteOut {
    @ApiModelProperty("具体类")
    private List<FavouriteInformationClass> classes;
    @ApiModelProperty("地点")
    private List<FavouriteLocation> locations;
    @ApiModelProperty("消息")
    private List<FavouriteMessage> messages;


    public FavouriteOut(List<FavouriteInformationClass> classes, List<FavouriteLocation> locations, List<FavouriteMessage> messages) {
        this.classes = classes;
        this.locations = locations;
        this.messages = messages;
    }

    public List<FavouriteInformationClass> getClasses() {
        return classes;
    }

    public void setClasses(List<FavouriteInformationClass> classes) {
        this.classes = classes;
    }

    public List<FavouriteLocation> getLocations() {
        return locations;
    }

    public void setLocations(List<FavouriteLocation> locations) {
        this.locations = locations;
    }

    public List<FavouriteMessage> getMessages() {
        return messages;
    }

    public void setMessages(List<FavouriteMessage> messages) {
        this.messages = messages;
    }
}
