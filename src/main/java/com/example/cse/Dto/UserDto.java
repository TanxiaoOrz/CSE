package com.example.cse.Dto;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Utils.Model;
import com.example.cse.Mapper.ProfessionMapper;

//UserModel的相关构造暂时被停用，请记得修改
public class UserDto {
    private Integer Uid;
    private String UserCode;
    private String Name;
    private String Sex;
    private Profession Profession;
    private String Grade;
    private Model userModel;
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
    public Profession getProfession() {
        return Profession;
    }
    public void setProfession(Profession profession) {
        Profession = profession;
    }
    public String getGrade() {
        return Grade;
    }
    public void setGrade(String grade) {
        Grade = grade;
    }
    public Model getUserModel() {
        return userModel;
    }
    public void setUserModel(Model userModel) {
        this.userModel = userModel;
    }

    public UserDto(User user, ProfessionMapper professionMapper){
        this.setUid(user.getUid());
        this.setName(user.getUserName());
        this.setUserCode(user.getUserCode());
        this.setSex(user.getSex());
        this.setProfession(professionMapper.getProfessionByPid(user.getUid()));
        this.setGrade(user.getGrade());
        this.setUserPass(user.getUserPass());
        //this.setUserModel(new Gson().fromJson(user.getUserModel(),Model.class));
    }


    @Override
    public String toString() {
        return "UserDto{" +
                "Uid=" + Uid +
                ", UserCode='" + UserCode + '\'' +
                ", Name='" + Name + '\'' +
                ", Sex='" + Sex + '\'' +
                ", Profession='" + Profession + '\'' +
                ", Grade='" + Grade + '\'' +
                ", userModel=" + userModel +
                '}';
    }

}
