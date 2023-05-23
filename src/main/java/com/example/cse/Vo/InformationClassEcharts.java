package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "InformationClassEcharts", description = "信息类图标回传数据结构体")
public class InformationClassEcharts {
    @ApiModelProperty("实际时二维int数组\n"
            + "用于竞赛：第一级是时间分隔，第二级时竞赛等级分隔三二一\n"
            + "用于部门：第一级时星期，第二级开门时间段，关门时间段")
    private String listGroup;
    @ApiModelProperty("实际时一维int数组，用于报名与空缺的比例饼图，由前至后分别是未报名名额，报名未签到，已签到"
            + "用于资源：就是抢手等级data数组从0点到24点\n")
    private String list;
    @ApiModelProperty("实际时一维String数组，用于竞赛的时间年份表示,可能会比展示二位数组数量多，请稍微截取一下")
    private String nameList;

    public String getListGroup() {
        return listGroup;
    }

    public void setListGroup(String listGroup) {
        this.listGroup = listGroup;
    }

    public String getList() {
        return list;
    }

    public void setList(String list) {
        this.list = list;
    }

    public String getNameList() {
        return nameList;
    }

    public void setNameList(String nameList) {
        this.nameList = nameList;
    }

}
