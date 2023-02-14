package com.example.cse.Vo.in;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "UserPass",description = "获取token需要传递的结构体")
public class UserPass {
    @ApiModelProperty(value = "用户学号",required = true)
    private String userCode;
    @ApiModelProperty(value = "用户密码",required = true)
    private String userPass;

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }
}
