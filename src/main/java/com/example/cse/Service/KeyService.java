package com.example.cse.Service;

import com.example.cse.Entity.Recommend.KeyWord;
import com.example.cse.Entity.Recommend.KeyWordType;
import com.example.cse.Entity.Recommend.TypeWithKey;

import java.util.List;

public interface KeyService {
    Integer newKey(KeyWord keyWord);
    Integer newType(KeyWordType keyWordType);
    List<TypeWithKey> getAll();
}
