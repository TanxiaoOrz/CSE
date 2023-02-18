package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;
@ApiModel(value = "UserHobbyOut",description = "获取用户的hobby等级")
public class UserHobbyOut {
    @ApiModelProperty(value = "感兴趣的")
    private List<HobbyOut> interested;
    @ApiModelProperty(value = "普通的")
    private List<HobbyOut> common;
    @ApiModelProperty(value = "不感兴趣的")
    private List<HobbyOut> uninterested;

    public List<HobbyOut> getInterested() {
        return interested;
    }

    public void setInterested(List<HobbyOut> interested) {
        this.interested = interested;
    }

    public List<HobbyOut> getCommon() {
        return common;
    }

    public void setCommon(List<HobbyOut> common) {
        this.common = common;
    }

    public List<HobbyOut> getUninterested() {
        return uninterested;
    }

    public void setUninterested(List<HobbyOut> uninterested) {
        this.uninterested = uninterested;
    }
}
