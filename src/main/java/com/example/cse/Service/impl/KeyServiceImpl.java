package com.example.cse.Service.impl;

import com.example.cse.Entity.Recommend.KeyWord;
import com.example.cse.Entity.Recommend.KeyWordType;
import com.example.cse.Entity.Recommend.TypeWithKey;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Service.KeyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KeyServiceImpl implements KeyService {
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Override
    public Integer newKey(KeyWord keyWord) {
        return keyTypeMapper.newKeyword(keyWord);
    }

    @Override
    public Integer newType(KeyWordType keyWordType) {
        return keyTypeMapper.newKeywordType(keyWordType);
    }

    @Override
    public List<TypeWithKey> getAll() {
        List<TypeWithKey> typeWithKeys = keyTypeMapper.getAllType();
        typeWithKeys.forEach(typeWithKey -> typeWithKey.setKeyWords(keyTypeMapper.getKeysByTid(typeWithKey.getTid())));
        return typeWithKeys;
    }
}
