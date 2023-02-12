package com.example.cse.Entity.UserClass;

public class User {
    private Integer Uid;
    private String UserCode;
    private String Name;
    private String Sex;
    private String Profession;
    private String Grade;
    private String UserModel;
    private String UserPass;

    public String getUserPass() {
        return UserPass;
    }

    public void setUserPass(String userPass) {
        UserPass = userPass;
    }

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

    public void setUserModel(String userModel) {
        UserModel = userModel;
    }
    @Override
    public String toString() {
        return "User{" +
                "Uid=" + Uid +
                ", UserCode='" + UserCode + '\'' +
                ", Name='" + Name + '\'' +
                ", Sex='" + Sex + '\'' +
                ", Profession='" + Profession + '\'' +
                ", Grade='" + Grade + '\'' +
                ", UserModel='" + UserModel + '\'' +
                '}';
    }
}
