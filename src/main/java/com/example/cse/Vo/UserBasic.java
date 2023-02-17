package com.example.cse.Vo;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.Profession;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.models.auth.In;

@ApiModel(value = "UserBasicOut",description = "回传用户基本信息的结构体")
public class UserBasic {
    @ApiModelProperty("用户编号")
    protected Integer uid;
    @ApiModelProperty("用户学号")
    protected String userCode;
    @ApiModelProperty("用户名")
    protected String userName;
    @ApiModelProperty("用户年级")
    protected String grade;
    @ApiModelProperty("用户专业")
    protected Integer profession;
    @ApiModelProperty("用户性别")
    protected String sex;

    public UserBasic() {
    }

    public UserBasic(UserDto userDto) {
        this.uid = userDto.getUid();
        this.userCode = userDto.getUserCode();
        this.userName = userDto.getUserName();
        this.grade = userDto.getGrade();
        this.profession = userDto.getProfession().getPid();
        this.sex = userDto.getSex();
    }

    public Integer getUid() {
        return uid;
    }

    public String getUserCode() {
        return userCode;
    }

    public String getUserName() {
        return userName;
    }

    public String getGrade() {
        return grade;
    }

    public Integer getProfession() {
        return profession;
    }

    public String getSex() {
        return sex;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public void setProfession(Integer profession) {
        this.profession = profession;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
