package com.example.cse.Vo;

import com.example.cse.Utils.Exception.WrongDataException;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "管理员设置的传入传出类")
public class ManagerConfig {

    @ApiModelProperty(value = "后端服务器定时休眠是否开启，默认开启",example = "true")
    private Boolean sleepEnabled;
    @ApiModelProperty(value = "后端服务器定时删除是否开启，默认开启，如需开启要求休眠开启",example = "true")
    private Boolean deleteEnabled;
    @ApiModelProperty(value = "后端服务器定时计算模型是否开启，默认关闭",example = "false")
    private Boolean calculateEnabled;
    @ApiModelProperty(value = "后端服务器定时计算模型的工作内容级别，" +
            "0重新生成爱好并更新基本信息分数" +
            "1重新生成爱好" +
            "2更新爱好和基本信息分数" +
            "3更新基本信息" +
            "4更新爱好",
            example = "false")
    private Integer calculateDegree;

    public void checkValue() throws WrongDataException {
        if (sleepEnabled&&(deleteEnabled||calculateEnabled))
            throw new  WrongDataException("定时休眠未开启");
        if (calculateDegree<0 || calculateDegree >4) {
            throw new WrongDataException("错误的模型计算等级设定");
        }
    }

    public Boolean getSleepEnabled() {
        return sleepEnabled;
    }

    public void setSleepEnabled(Boolean sleepEnabled) {
        this.sleepEnabled = sleepEnabled;
    }

    public Boolean getDeleteEnabled() {
        return deleteEnabled;
    }

    public void setDeleteEnabled(Boolean deleteEnabled) {
        this.deleteEnabled = deleteEnabled;
    }

    public Boolean getCalculateEnabled() {
        return calculateEnabled;
    }

    public void setCalculateEnabled(Boolean calculateEnabled) {
        this.calculateEnabled = calculateEnabled;
    }

    public Integer getCalculateDegree() {
        return calculateDegree;
    }

    public void setCalculateDegree(Integer calculateDegree) {
        this.calculateDegree = calculateDegree;
    }
}
