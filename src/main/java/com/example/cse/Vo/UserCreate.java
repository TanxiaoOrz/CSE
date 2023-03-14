package com.example.cse.Vo;

import com.example.cse.Mapper.ProfessionMapper;
import com.example.cse.Mapper.UserMapper;
import com.example.cse.Utils.Exception.NoDataException;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

@ApiModel( description = "创建用户是传递的结构体")
public class UserCreate extends UserPass {
    @ApiModelProperty(value = "用户姓名")
    protected String userName;
    @ApiModelProperty(value = "用户年级")
    protected String grade;
    @ApiModelProperty(value = "用户性别,只接受男或女")
    protected String sex;
    @ApiModelProperty(value = "用户专业，只接受专业的唯一编号")
    protected Integer profession;

    public void checkNull(ProfessionMapper professionMapper, UserMapper userMapper) throws NoDataException {
        super.checkNull();
        if (!StringUtils.hasText(userName)) {
            throw new NoDataException(Vo.WrongPostParameter, "缺少用户名");
        }
        if (!StringUtils.hasText(grade)) {
            throw new NoDataException(Vo.WrongPostParameter, "缺少年级");
        }
        if (!StringUtils.hasText(sex)) {
            throw new NoDataException(Vo.WrongPostParameter, "缺少性别");
        }
        if (profession == null|| professionMapper.checkProfessionExist(profession,null) == 0) {
            throw new NoDataException(Vo.WrongPostParameter, "专业不存在");
        }
        if (userMapper.checkUserExist(userCode)!= 0 ){
            throw new NoDataException(Vo.WrongPostParameter,"学号已存在");
        }
    }

    public String getUserName() {

        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
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
}
