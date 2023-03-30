package com.example.cse.Dto;

import com.example.cse.Entity.UserClass.Calender;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;

@ApiModel(value = "CalenderDto",description = "待办日历")
public class CalenderDto<T> {
    @ApiModelProperty(value = "时间")
    private Date Time;
    @ApiModelProperty(value = "描述")
    private String Description;
    @ApiModelProperty(value = "关联的信息")
    private T relation;
    @ApiModelProperty(value = "信息的类型")
    private String Type;


    public CalenderDto() {
    }

    public CalenderDto(Calender calender, T relation, String Type) {
        Time = calender.getTime();
        Description = calender.getDescription();
        this.relation = relation;
        this.Type = Type;
    }



    public T getRelation() {
        return relation;
    }

    public void setRelation(T relation) {
        this.relation = relation;
    }

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        Type = type;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public Date getTime() {
        return Time;
    }

    public void setTime(Date time) {
        Time = time;
    }
}
