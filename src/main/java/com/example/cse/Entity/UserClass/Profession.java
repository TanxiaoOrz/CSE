package com.example.cse.Entity.UserClass;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "Profession", description = "返回专业数据的结构体")
public class Profession{
    @ApiModelProperty(value = "专业名称")
    protected String professionName;
    @ApiModelProperty(value = "专业描述")
    protected String professionDescription;
    @ApiModelProperty(value = "唯一id")
    protected Integer Pid;

    public String getProfessionName() {
        return professionName;
    }

    public void setProfessionName(String professionName) {
        this.professionName = professionName;
    }

    public String getProfessionDescription() {
        return professionDescription;
    }

    public void setProfessionDescription(String professionDescription) {
        this.professionDescription = professionDescription;
    }

    public Integer getPid() {
        return Pid;
    }

    public void setPid(Integer pid) {
        Pid = pid;
    }
}
