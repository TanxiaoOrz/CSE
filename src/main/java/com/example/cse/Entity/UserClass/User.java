package com.example.cse.Entity.UserClass;

import com.example.cse.Utils.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel
public class User {

    @ApiModelProperty("用户编号")
    private Integer Uid;
    @ApiModelProperty("用户学号")
    private String UserCode;
    @ApiModelProperty("用户名")
    private String Name;
    @ApiModelProperty("用户性别")
    private String Sex;
    @ApiModelProperty("用户专业")
    private String Profession;
    @ApiModelProperty("用户年级")
    private String Grade;
    @ApiModelProperty("用户偏好模型")
    private String UserModel;

    public Integer getUid() {
        return Uid;
    }

    public void setUid(Integer uid) {
        Uid = uid;
    }

    public String getUserCode() {
        return UserCode;
    }

    public void setUserCode(String userCode) {
        UserCode = userCode;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getSex() {
        return Sex;
    }

    public void setSex(String sex) {
        Sex = sex;
    }

    public String getProfession() {
        return Profession;
    }

    public void setProfession(String profession) {
        Profession = profession;
    }

    public String getGrade() {
        return Grade;
    }

    public void setGrade(String grade) {
        Grade = grade;
    }

    public String getUserModel() {
        return UserModel;
    }

    public void setUserModel(Model userModel) {
        this.userModel = userModel;
    }

    public void setUserModel(String userModel) {
        UserModel = userModel;
    }

    private Model userModel;
}
