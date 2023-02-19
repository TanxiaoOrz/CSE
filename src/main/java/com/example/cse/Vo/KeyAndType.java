package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel("KeyAndType")
public class KeyAndType {
    @ApiModelProperty(value = "关键词等级名")
    private String keyName;
    @ApiModelProperty(value = "关键词等级描述")
    private String keyResume;
    @ApiModelProperty(value = "关键词类型名")
    private String typeName;
    @ApiModelProperty(value = "关键词类型描述")
    private String typeResume;

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
