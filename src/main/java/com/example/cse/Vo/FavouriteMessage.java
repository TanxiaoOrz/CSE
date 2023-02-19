package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.Message;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;

@ApiModel(value = "FavouriteMessage",description = "用户喜欢的消息")
public class FavouriteMessage {

    @ApiModelProperty(value = "消息编号")
    private Integer Mid;

    public Integer getMid() {
        return Mid;
    }

    public void setMid(Integer mid) {
        this.Mid = mid;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    @ApiModelProperty(value = "消息标题")
    private String Name;//名字
    @ApiModelProperty(value ="创建时间")
    private Date Time;

    @ApiModelProperty(value ="所属类型")
    private String Type;

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        Type = type;
    }

    public Date getTime() {
        return Time;
    }

    public void setTime(Date time) {
        Time = time;
    }
}
