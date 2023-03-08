package com.example.cse.Service.impl;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Mapper.InformationClassMapper;
import com.example.cse.Service.InformationClassService;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.InformationClassDtoFactory;
import com.example.cse.Utils.SearchUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InformationClassServiceImpl implements InformationClassService {
    @Autowired
    InformationClassMapper informationClassMapper;
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
    public Integer newInformationClass(InformationClass informationClass) {
        informationClass.setZeroToNull();
        return informationClassMapper.newInformationClass(informationClass);
    }

    @Override
    public Integer updateInformationClass(InformationClass informationClass) throws WrongDataException {
        InformationClass old ;
        try {
            old = informationClassMapper.getInformationClassByRule(informationClass.getCid(),null,null).get(0);
        }catch (ArrayIndexOutOfBoundsException e) {
            throw new WrongDataException("错误的编号");
        }

        if (informationClass.checkUpdate(old))
            throw new WrongDataException("没有修改");
        informationClass.setZeroToNull();
        return informationClassMapper.updateInformationClass(informationClass);
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

        return dtos.subList(0,classLimit);

    }

    public List<InformationClassDto> getInformationClassesAll(UserDto userDto, String type) {
        List<InformationClass> informationClasses = informationClassMapper.searchInformationClass(type, null, null, null);
        return informationClassDtoFactory.getInformationClassDtosByRankScore(informationClasses, userDto);
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
