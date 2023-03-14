package com.example.cse.Vo;

import com.example.cse.Dto.CalenderDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(description = "用户的代办日历包装类")
public class CalenderOut {
    @ApiModelProperty(value = "当前日期之前")
    private List<CalenderDto<? super Object>> before;
    @ApiModelProperty(value = "当前日期之后")
    private List<CalenderDto<? super Object>> after;

    public List<CalenderDto<? super Object>> getBefore() {
        return before;
    }

    public void setBefore(List<CalenderDto<? super Object>> before) {
        this.before = before;
    }

    public List<CalenderDto<? super Object>> getAfter() {
        return after;
    }

    public void setAfter(List<CalenderDto<? super Object>> after) {
        this.after = after;
    }
}
