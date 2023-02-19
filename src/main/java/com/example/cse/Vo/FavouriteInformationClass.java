package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.InformationClass;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;
import java.util.List;

@ApiModel(value = "FavouriteInformationClass",description = "用户喜欢的具体类")
public class FavouriteInformationClass{
    @ApiModelProperty(value = "具体类编号")
    private Integer Cid;
    @ApiModelProperty(value = "具体类名字")
    private String Name;//名字
    @ApiModelProperty(value = "具体类类型")
    private String Type;//类型

    public Integer getCid() {
        return Cid;
    }

    public void setCid(Integer cid) {
        Cid = cid;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        Type = type;
    }

    @ApiModelProperty(value = "创建时间")
    private Date Time;

    @ApiModelProperty(value = "所附带的关键词")
    List<KeyAndType> keys;

    public Date getTime() {
        return Time;
    }

    public void setTime(Date time) {
        Time = time;
    }

    public List<KeyAndType> getKeys() {
        return keys;
    }

    public void setKeys(List<KeyAndType> keys) {
        this.keys = keys;
    }
}
