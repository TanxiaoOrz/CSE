package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.KeyWord;

public class Contest extends InformationClass{
    private Integer Cid;
    private Integer Profession;
    private Integer Level;

    private KeyWord profession;
    private KeyWord level;

    @Override
    public Integer getClassScore() {
        return null;
    }
}
