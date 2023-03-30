package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "选择对应连接的信息类型与编号")
public class TypeString {

    @ApiModelProperty(value = "关联的id")
    private Integer id;
    @ApiModelProperty(value = "关联的类型",allowableValues = "informationClass,location,message")
    private String type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean checkData() {
        return type.equals("informationClass")||type.equals("location")||type.equals("message");
    }
}
