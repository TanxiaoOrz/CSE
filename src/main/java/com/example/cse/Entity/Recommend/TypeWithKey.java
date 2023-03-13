package com.example.cse.Entity.Recommend;

import java.util.List;

public class TypeWithKey extends KeyWordType{

    List<KeyWord> keyWords;

    public List<KeyWord> getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(List<KeyWord> keyWords) {
        this.keyWords = keyWords;
    }
}
