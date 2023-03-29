package com.example.cse.Entity.UserClass;

import com.example.cse.Vo.UserCreate;

public class User {
    private Integer uid;
    private String userCode;
    private String userName;
    private String sex;
    private Integer profession;
    private String grade;
    private String userModel;
    private String userPass;
    public User(UserCreate userCreate) {
        userCode = userCreate.getUserCode();
        userName = userCreate.getUserName();
        sex = userCreate.getSex();
        profession = userCreate.getProfession();
        grade = userCreate.getGrade();
        userPass = userCreate.getUserPass();
    }

    public User() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }



    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getProfession() {
        return profession;
    }

    public void setProfession(Integer profession) {
        this.profession = profession;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getUserModel() {
        return userModel;
    }

    public void setUserModel(String userModel) {
        this.userModel = userModel;
    }
}
