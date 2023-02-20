package com.example.cse.Vo;

import com.example.cse.Dto.CalenderDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel("用户的代办日历")
public class CalenderOut {
    @ApiModelProperty(value = "当前日期之前")
    private List<CalenderDto> before;
    @ApiModelProperty(value = "当前日期之后")
    private List<CalenderDto> after;

    public List<CalenderDto> getBefore() {
        return before;
    }

    public void setBefore(List<CalenderDto> before) {
        this.before = before;
    }

    public List<CalenderDto> getAfter() {
        return after;
    }

    public void setAfter(List<CalenderDto> after) {
        this.after = after;
    }
}
