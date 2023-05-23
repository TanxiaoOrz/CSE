package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "Suggest",description = "推荐制表返回实体")
public class Suggest {

    @ApiModelProperty(value = "显示对象名称")
    private String name;
    @ApiModelProperty(value = "分数")
    private Integer value;
    @ApiModelProperty(value = "跳转id")
    private Integer id;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
