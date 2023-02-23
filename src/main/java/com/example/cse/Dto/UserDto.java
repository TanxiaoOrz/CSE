package com.example.cse.Dto;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.ProfessionMapper;

import java.util.HashMap;
import java.util.List;

//UserModel的相关构造暂时被停用，请记得修改
public class UserDto {
    private Integer Uid;
    private String UserCode;
    private String UserName;
    private String Sex;
    private Profession Profession;
    private String Grade;
    private List<ModelDto> modelDtos;



    private String UserPass;

    HashMap<Integer,Integer> informationClassModel;
    HashMap<Integer,Integer> keywordModels;
    HashMap<Integer,Integer> locationModels;
    public List<ModelDto> getModelDtos() {
        return modelDtos;
    }

    public void setModelDtos(List<ModelDto> modelDtos) {
        this.modelDtos = modelDtos;
    }
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
    public String getUserName() {
        return UserName;
    }
    public void setUserName(String userName) {
        UserName = userName;
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

    public HashMap<Integer, Integer> getInformationClassModel() {
        return informationClassModel;
    }

    public void setInformationClassModel(HashMap<Integer, Integer> informationClassModel) {
        this.informationClassModel = informationClassModel;
    }

    public HashMap<Integer, Integer> getKeywordModels() {
        return keywordModels;
    }

    public void setKeywordModels(HashMap<Integer, Integer> keywordModels) {
        this.keywordModels = keywordModels;
    }

    public HashMap<Integer, Integer> getLocationModels() {
        return locationModels;
    }

    public void setLocationModels(HashMap<Integer, Integer> locationModels) {
        this.locationModels = locationModels;
    }

    public UserDto(User user, ProfessionMapper professionMapper){
        this.setUid(user.getUid());
        this.setUserName(user.getUserName());
        this.setUserCode(user.getUserCode());
        this.setSex(user.getSex());
        this.setProfession(professionMapper.getProfessionByPid(user.getUid()));
        this.setGrade(user.getGrade());
        this.setUserPass(user.getUserPass());
    }

}
