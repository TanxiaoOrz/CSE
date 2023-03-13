package com.example.cse.Service.impl;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Service.InformationClassService;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.InformationClassDtoFactory;
import com.example.cse.Utils.SearchUtils;
import com.example.cse.Vo.InformationClassIn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InformationClassServiceImpl implements InformationClassService {
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Autowired
    InformationClassDtoFactory informationClassDtoFactory;

    @Override
    public InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit) {
        InformationClass informationClass = informationClassMapper.getInformationClassByRule(cid,null,null).get(0);

        InformationClassDto informationClassDto = informationClassDtoFactory.getInformationClassDto(informationClass);

        informationClassDtoFactory.calculateShowMessages(informationClassDto,userDto,limit);

        return informationClassDto;
    }

    @Override
    public Integer newInformationClass(InformationClassIn informationClass) {
        informationClass.setZeroToNull();

        Integer integer = informationClassMapper.newInformationClass(informationClass);
        for (Integer kid:informationClass.getKeyAndTypes()) {
            keyTypeMapper.newKeyAndTypeLink(informationClass.getCid(),kid);
        }
        return integer;
    }

    @Override
    public Integer updateInformationClass(InformationClassIn informationClass) throws WrongDataException {
        InformationClass old ;
        try {
            old = informationClassMapper.getInformationClassByRule(informationClass.getCid(),null,null).get(0);
        }catch (IndexOutOfBoundsException e) {
            throw new WrongDataException("错误的编号");
        }

        if (informationClass.checkUpdate(old))
            throw new WrongDataException("没有修改");
        informationClass.setZeroToNull();
        Integer integer = informationClassMapper.updateInformationClass(informationClass);

        List<Integer> keys = informationClass.getKeyAndTypes();
        if (keys != null) {
            List<Integer> olds = keyTypeMapper.getKidsByCid(informationClass.getCid());
            ArrayList<Integer> delete = new ArrayList<>(olds);
            delete.removeAll(keys);
            ArrayList<Integer> insert = new ArrayList<>(keys);
            insert.removeAll(olds);
            for (Integer kid : delete) {
                integer = keyTypeMapper.deleteKeyAndTypeLink(informationClass.getCid(),kid);
            }
            for (Integer kid : insert) {
                integer = keyTypeMapper.newKeyAndTypeLink(informationClass.getCid(),kid);
            }
        }

        return integer;
    }

    @Override
    public Integer deleteInformationClass(Integer cid) {
        return informationClassMapper.deleteInformationClass(cid);
    }

    @Override
    public List<InformationClassDto> getInformationClassesShow(UserDto userDto, Integer classLimit, Integer messageLimit, String type) {

        List<InformationClass> types = informationClassMapper.searchInformationClass(type, null, null, null);
        List<InformationClassDto> dtos = informationClassDtoFactory.getInformationClassDtosByRankScore(types, userDto);
        List<InformationClassDto> deletes = new ArrayList<>();

        int count = 0;

        for (InformationClassDto informationClassDto: dtos) {
            if (informationClassDtoFactory.calculateShowMessages(informationClassDto,userDto,messageLimit)) {
                count++;
            }else {
                deletes.add(informationClassDto);
            }
            if (count == classLimit)
                break;
        }

        if (!deletes.isEmpty())
            dtos.removeAll(deletes);

        if (dtos.size()<classLimit)
            return dtos;
        else
            return dtos.subList(0,classLimit);

    }


    @Override
    public List<InformationClassDto> searchInformationClasses(String type, String search) {
        List<String> adds = new ArrayList<>();
        List<String> minuses = new ArrayList<>();
        List<String> defaults = new ArrayList<>();

        SearchUtils.splitSearch(search,adds,minuses,defaults);

        List<InformationClass> informationClasses = informationClassMapper.searchInformationClass(type, defaults, adds, minuses);

        return informationClassDtoFactory.getInformationClassDtosByRankScore(informationClasses,null);
    }
}
