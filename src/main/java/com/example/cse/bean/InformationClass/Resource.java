package com.example.cse.bean.InformationClass;

import com.example.cse.bean.Recommend.KeyWord;

public class Resource extends InformationClass{
    private Integer Rid;//唯一标识
    private Integer Count;//count关键词的标识
    private Integer Popular;//popular关键词的标识

    private KeyWord count;//总数量级
    private KeyWord popular;//抢手程度

    @Override
    public Integer getClassScore() {
        return null;
    }
}
