package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.KeyWord;

public class Activity extends InformationClass{
    private Integer Aid;//唯一标识富
    private Integer Section;
    private Integer Request;
    private Integer ActivityScore;
    private Integer Location;

    private Section section;
    private Location location;
    private KeyWord activityScore;
    private KeyWord request;

    @Override
    public Integer getClassScore() {
        return null;
    }
}
