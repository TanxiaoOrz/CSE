package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.KeyWord;

public class Section extends InformationClass{
    private Integer Sid;//唯一标识符
    private Integer Location;//对应属性的链接标识
    private Integer Profession;
    private KeyWord profession;//专业的关键字属性
    private Location location;//所在位置关键字属性

    @Override
    public Integer getClassScore() {
        return null;
    }
}