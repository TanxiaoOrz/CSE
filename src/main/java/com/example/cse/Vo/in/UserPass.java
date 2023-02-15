package com.example.cse.Vo.in;

import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

@ApiModel(value = "UserPass",description = "获取token需要传递的结构体")
public class UserPass {
    @ApiModelProperty(value = "用户学号",required = true)
    protected String userCode;
    @ApiModelProperty(value = "用户密码",required = true)
    protected String userPass;

    public void checkNull() throws NoDataException{
        if (!StringUtils.hasText(userCode))
            throw new NoDataException(Vo.WrongPostParameter,"缺少用户名");
        if (!StringUtils.hasText(userPass))
            throw new NoDataException(Vo.WrongPostParameter,"缺少密码");
    }

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
