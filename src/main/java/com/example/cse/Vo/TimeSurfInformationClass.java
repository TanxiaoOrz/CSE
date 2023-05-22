package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.InformationClass;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(value = "TimeSurfInformationClass", description = "信息类访问量随时间变化的数据结构体")
public class TimeSurfInformationClass {
    @ApiModelProperty("时间点名称")
    List<String> timeName;
    @ApiModelProperty("时间点对应的访问数据数组,表示当天该信息类的访问次数")
    List<List<Integer>> surfTimes;
    @ApiModelProperty("信息类数组")
    List<InformationClass> informationClasses;

    public List<String> getTimeName() {
        return timeName;
    }

    public void setTimeName(List<String> timeName) {
        this.timeName = timeName;
    }

    public List<List<Integer>> getSurfTimes() {
        return surfTimes;
    }

    public void setSurfTimes(List<List<Integer>> surfTimes) {
        this.surfTimes = surfTimes;
    }

    public List<InformationClass> getInformationClasses() {
        return informationClasses;
    }

    public void setInformationClasses(List<InformationClass> informationClasses) {
        this.informationClasses = informationClasses;
    }
}
