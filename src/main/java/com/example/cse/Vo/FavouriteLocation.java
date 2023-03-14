package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;
@ApiModel(description = "用户喜欢的地点结构体")
public class FavouriteLocation{

    @ApiModelProperty(value = "具体类编号")
    private Integer lid;
    @ApiModelProperty(value = "具体类名字")
    private String name;//名字
    @ApiModelProperty(value ="创建时间")
    private Date time;

    public Integer getLid() {
        return lid;
    }

    public void setLid(Integer lid) {
        this.lid = lid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
