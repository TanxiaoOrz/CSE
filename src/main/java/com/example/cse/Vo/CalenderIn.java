package com.example.cse.Vo;

import com.example.cse.Utils.TypeString;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;

@ApiModel(value = "CalenderIn",description = "传入的")
public class CalenderIn {
    @ApiModelProperty(value = "时间")
    private Date Time;
    @ApiModelProperty(value = "描述")
    private String Description;
    @ApiModelProperty(value = "关联信息的指向描述体")
    private TypeString RelationFunction;

    public Date getTime() {
        return Time;
    }

    public void setTime(Date time) {
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
