package com.example.cse.Vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "日志的生成类传入日志信息")
public class CalenderIn {
    @ApiModelProperty(value = "时间")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private String time;
    @ApiModelProperty(value = "描述")
    private String description;
    @ApiModelProperty(value = "关联信息的指向描述体")
    private TypeString relationFunction;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public TypeString getRelationFunction() {
        return relationFunction;
    }

    public void setRelationFunction(TypeString relationFunction) {
        this.relationFunction = relationFunction;
    }
}
