package com.example.cse.Vo;

import com.example.cse.Entity.Recommend.KeyAndType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(value = "FavouriteInformationClass",description = "用户喜欢的具体类")
public class FavouriteInformationClass{
    @ApiModelProperty(value = "具体类编号")
    private Integer cid;
    @ApiModelProperty(value = "具体类名字")
    private String name;//名字
    @ApiModelProperty(value = "具体类类型")
    private String type;//类型
    @ApiModelProperty(value = "关键词及类型")
    private List<KeyAndType> keys;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }


    public List<KeyAndType> getKeys() {
        return keys;
    }

    public void setKeys(List<KeyAndType> keys) {
        this.keys = keys;
    }
}
