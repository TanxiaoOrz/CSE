package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.InformationClass;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(description = "信息类的传入类附带了关键词")
public class InformationClassIn extends InformationClass {
    @ApiModelProperty("附属的关键词的id数组")
    private List<Integer> keyAndTypes;
    @ApiModelProperty("所在地点的id数组")
    private List<Integer> location;

    public List<Integer> getKeyAndTypes() {
        return keyAndTypes;
    }

    public void setKeyAndTypes(List<Integer> keyAndTypes) {
        this.keyAndTypes = keyAndTypes;
    }

    public List<Integer> getLocation() {
        return location;
    }

    public void setLocation(List<Integer> location) {
        this.location = location;
    }
}
