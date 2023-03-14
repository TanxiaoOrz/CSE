package com.example.cse.Dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel("推荐模型")
public class ModelDto {

    @ApiModelProperty("推荐对象的id")
    Integer id;
    @ApiModelProperty("推荐分值")
    Integer score;
    @ApiModelProperty(value = "该模型针对的对象类型",allowableValues = "keyword,informationClass,location")
    String type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
