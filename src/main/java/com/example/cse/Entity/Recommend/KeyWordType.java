package com.example.cse.Entity.Recommend;

import io.swagger.annotations.ApiModelProperty;

public class KeyWordType {
    private Integer tid;
    @ApiModelProperty(value = "关键词类型名")
    private String typeName;
    @ApiModelProperty(value = "关键词类型描述")
    private String typeResume;

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeResume() {
        return typeResume;
    }

    public void setTypeResume(String typeResume) {
        this.typeResume = typeResume;
    }
}
