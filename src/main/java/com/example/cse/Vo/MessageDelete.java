package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "删除专用传入")
public class MessageDelete {
    @ApiModelProperty("删除的id")
    Integer mid;
    @ApiModelProperty("是否过时，0没有，1过时")
    Integer out;

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public Integer getOut() {
        return out;
    }

    public void setOut(Integer out) {
        this.out = out;
    }
}
