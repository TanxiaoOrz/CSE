package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.InformationClass;

import java.util.List;

public class InformationClassIn extends InformationClass {
    List<Integer> keyAndTypes;

    public List<Integer> getKeyAndTypes() {
        return keyAndTypes;
    }

    public void setKeyAndTypes(List<Integer> keyAndTypes) {
        this.keyAndTypes = keyAndTypes;
    }
}
