package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;
@ApiModel(value = "FavouriteLocation",description = "用户喜欢的地点")
public class FavouriteLocation{

    @ApiModelProperty(value = "具体类编号")
    private Integer Cid;
    @ApiModelProperty(value = "具体类名字")
    private String Name;//名字
    @ApiModelProperty(value ="创建时间")
    private Date Time;

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

    public Date getTime() {
        return Time;
    }

    public void setTime(Date time) {
        Time = time;
    }
}
