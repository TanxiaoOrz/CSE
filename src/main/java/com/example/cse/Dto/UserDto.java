package com.example.cse.Dto;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.ProfessionMapper;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

//UserModel的相关构造暂时被停用，请记得修改
public class UserDto {
    private Integer Uid;
    private String UserCode;
    private String UserName;
    private String Sex;
    private Profession Profession;
    private String Grade;
    private List<ModelDto> userModel;
    private String UserPass;
    private ConcurrentHashMap<Integer, Integer> informationClassModel;
    private ConcurrentHashMap<Integer, Integer> messageModel;
    private ConcurrentHashMap<Integer, Integer> locationModels;
    private ConcurrentHashMap<Integer, Integer> keywordModels;

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

    public List<ModelDto> getUserModel() {
        return userModel;
    }

    public void setUserModel(List<ModelDto> userModel) {
        this.userModel = userModel;
    }

    public void setUserModel(String userModel) {
        if (userModel != null) {
            this.userModel = ModelDto.getModelDtos(userModel);
        }
    }

    public ConcurrentHashMap<Integer, Integer> getInformationClassModel() {
        return informationClassModel;
    }

    public void setInformationClassModel(ConcurrentHashMap<Integer, Integer> informationClassModel) {
        this.informationClassModel = informationClassModel;
    }

    public ConcurrentHashMap<Integer, Integer> getMessageModel() {
        return messageModel;
    }

    public void setMessageModel(ConcurrentHashMap<Integer, Integer> messageModel) {
        this.messageModel = messageModel;
    }

    public ConcurrentHashMap<Integer, Integer> getLocationModels() {
        return locationModels;
    }

    public void setLocationModels(ConcurrentHashMap<Integer, Integer> locationModels) {
        this.locationModels = locationModels;
    }

    public ConcurrentHashMap<Integer, Integer> getKeywordModels() {
        return keywordModels;
    }

    public void setKeywordModels(ConcurrentHashMap<Integer, Integer> keywordModels) {
        this.keywordModels = keywordModels;
    }

    public UserDto(User user, ProfessionMapper professionMapper) {
        this.setUid(user.getUid());
        this.setUserName(user.getUserName());
        this.setUserCode(user.getUserCode());
        this.setSex(user.getSex());
        this.setProfession(professionMapper.getProfessionByPid(user.getProfession()));
        this.setGrade(user.getGrade());
        this.setUserPass(user.getUserPass());

        if (user.getUserModel() != null) {
            setUserModel(user.getUserModel());

        }
    }

}
