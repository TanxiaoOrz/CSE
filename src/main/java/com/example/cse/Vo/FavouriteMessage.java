package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.Message;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;

@ApiModel(value = "用户喜欢的消息结构体")
public class FavouriteMessage {

    @ApiModelProperty(value = "消息编号")
    private Integer mid;

    @ApiModelProperty(value = "消息标题")
    private String title;//名字
    @ApiModelProperty(value ="创建时间")
    private Date time;

    @ApiModelProperty(value ="所属类型")
    private String type;

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
