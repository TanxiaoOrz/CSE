package com.example.cse.Vo;

import com.example.cse.Utils.Exception.NoDataException;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel("用户修改爱好时的结构体")
public class UserHobbyIn {
    @ApiModelProperty(value = "修改的爱好编号")
    private Integer hid;
    @ApiModelProperty(value = "新的等级",example = "common",notes = "只允许interested,uninterested,common")
    private String degree;

    public void checkNull() throws NoDataException {
        if (hid == null)
            throw new NoDataException(Vo.WrongPostParameter,"没有hid");
        if (!degree.equals("common")&&!degree.equals("interested")&&!degree.equals("uninterested"))
            throw new NoDataException(Vo.WrongPostParameter,"错误的degree值");
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }
}
