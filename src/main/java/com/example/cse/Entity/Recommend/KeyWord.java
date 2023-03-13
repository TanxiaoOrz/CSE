package com.example.cse.Entity.Recommend;

import io.swagger.annotations.ApiModelProperty;

public class KeyWord {
    @ApiModelProperty(value = "关键词的编号")
    private Integer kid;
    @ApiModelProperty(value = "关键词等级名")
    private String keyName;
    @ApiModelProperty(value = "关键词等级描述")
    private String keyResume;

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }

    public String getKeyResume() {
        return keyResume;
    }

    public void setKeyResume(String keyResume) {
        this.keyResume = keyResume;
    }
}
