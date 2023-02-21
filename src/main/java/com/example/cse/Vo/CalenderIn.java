package com.example.cse.Vo;

import com.example.cse.Utils.TypeString;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@ApiModel(value = "CalenderIn",description = "传入的")
public class CalenderIn {
    @ApiModelProperty(value = "时间",hidden = false)
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private String Time;
    @ApiModelProperty(value = "描述",hidden = false)
    private String Description;
    @ApiModelProperty(value = "关联信息的指向描述体",hidden = false)
    private TypeString RelationFunction;

    public String getTime() {
        return Time;
    }

    public void setTime(String time) {
        Time = time;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public TypeString getRelationFunction() {
        return RelationFunction;
    }

    public void setRelationFunction(TypeString relationFunction) {
        RelationFunction = relationFunction;
    }
}
