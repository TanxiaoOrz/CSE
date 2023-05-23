package com.example.cse.Service.impl;

import com.example.cse.Dto.InformationClassDto;
import com.example.cse.Dto.SurfCounts;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Mapper.*;
import com.example.cse.Service.InformationClassService;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.InformationClassDtoFactory;
import com.example.cse.Utils.SearchUtils;
import com.example.cse.Vo.InformationClassEcharts;
import com.example.cse.Vo.InformationClassIn;
import com.example.cse.Vo.Suggest;
import com.google.gson.Gson;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Service
public class InformationClassServiceImpl implements InformationClassService {
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Autowired
    FavouriteMapper favouriteMapper;
    @Autowired
    LocationMapper locationMapper;
    @Autowired
    InformationClassDtoFactory informationClassDtoFactory;
    @Autowired
    SurfMapper surfMapper;

    @Override
    public InformationClassDto getInformationClass(UserDto userDto, Integer cid, Integer limit) {
        InformationClass informationClass = informationClassMapper.getInformationClassByRule(cid, null, null).get(0);

        InformationClassDto informationClassDto = informationClassDtoFactory.getInformationClassDto(informationClass);

        informationClassDtoFactory.calculateShowMessages(informationClassDto, userDto, limit);
        if (userDto == null) {
            informationClassDto.setIsFavourite(0);
        } else
            informationClassDto.setIsFavourite(
                    favouriteMapper.getFavouriteCidByUid(userDto.getUid()).contains(informationClassDto.getCid()) ? 1
                            : 0);
        return informationClassDto;
    }

    @Override
    public Integer newInformationClass(InformationClassIn informationClass) {
        informationClass.setZeroToNull();

        Integer integer = informationClassMapper.newInformationClass(informationClass);
        for (Integer kid : informationClass.getKeyAndTypes()) {
            keyTypeMapper.newKeyAndTypeLink(informationClass.getCid(), kid);
        }
        return integer;
    }

    @Override
    public Integer updateInformationClass(InformationClassIn informationClass) throws WrongDataException {

        if (informationClassMapper.getInformationClassByRule(informationClass.getCid(), null, null).isEmpty())
            throw new WrongDataException("错误的编号");

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
                integer += keyTypeMapper.deleteKeyAndTypeLink(informationClass.getCid(), kid);
            }
            for (Integer kid : insert) {
                integer += keyTypeMapper.newKeyAndTypeLink(informationClass.getCid(), kid);
            }
        }

        List<Integer> location = informationClass.getLocation();
        if (location != null) {
            List<Integer> olds = locationMapper.getLidByCid(informationClass.getCid());
            ArrayList<Integer> delete = new ArrayList<>(olds);
            delete.removeAll(location);
            ArrayList<Integer> insert = new ArrayList<>(location);
            insert.removeAll(olds);
            for (Integer lid : delete) {
                integer = informationClassMapper.newInformationClassRelationLocation(lid, informationClass.getCid());
            }
            for (Integer lid : insert) {
                integer = informationClassMapper.deleteInformationClassRelationLocation(lid, informationClass.getCid());
            }
        }

        return integer;
    }

    @Override
    public Integer deleteInformationClass(Integer cid) {
        return informationClassMapper.deleteInformationClass(cid);
    }

    @Override
    public List<InformationClassDto> getInformationClassesShow(UserDto userDto, Integer classLimit,
            Integer messageLimit, String type) {

        List<InformationClass> types = informationClassMapper.searchInformationClass(type, null, null, null, null);
        List<InformationClassDto> dtos = informationClassDtoFactory.getInformationClassDtosByRankScore(types, userDto);
        List<InformationClassDto> deletes = new ArrayList<>();

        int count = 0;

        for (InformationClassDto informationClassDto : dtos) {
            if (informationClassDtoFactory.calculateShowMessages(informationClassDto, userDto, messageLimit)) {
                count++;
            } else {
                deletes.add(informationClassDto);
            }
            if (count == classLimit)
                break;
        }

        if (!deletes.isEmpty())
            dtos.removeAll(deletes);

        if (dtos.size() < classLimit)
            return dtos;
        else
            return dtos.subList(0, classLimit);

    }

    @Override
    public List<InformationClassDto> searchInformationClasses(String type, String search, Integer keyId) {
        List<String> adds = new ArrayList<>();
        List<String> minuses = new ArrayList<>();
        List<String> defaults = new ArrayList<>();

        SearchUtils.splitSearch(search, adds, minuses, defaults);

        List<InformationClass> informationClasses = informationClassMapper.searchInformationClass(type, defaults, adds,
                minuses, keyId);

        return informationClassDtoFactory.getInformationClassDtosByRankScore(informationClasses, null);
    }

    @Override
    public List<Suggest> getInformationClassWordCloud(UserDto userDto, Integer count, String type) {
        List<SurfCounts> counts;
        if (userDto == null) {
            counts = surfMapper.getSurfMostInformationClassesCountsAll();
        } else {
            counts = surfMapper.getSurfMostInformationClassesCounts(userDto.getUid());
        }
        ArrayList<Suggest> suggests = new ArrayList<>(counts.size());

        if (count != null && count < 10 && count > 0) { // 数量过滤
            counts = counts.subList(0, count);
        }

        counts.forEach(surfCounts -> {
            InformationClass informationClass = informationClassMapper
                    .getInformationClassByRule(surfCounts.getId(), null, null).get(0);
            if (type == null || type.equals(informationClass.getType())) { // 类型过滤
                Suggest suggest = new Suggest();
                suggest.setId(surfCounts.getId());
                suggest.setValue(surfCounts.getCounts());
                suggest.setName(informationClass.getName());
                suggests.add(suggest);
            }
        });
        return suggests;
    }

    @Override
    public InformationClassEcharts getEcharts(Integer id, String type) throws WrongDataException {
        InformationClassEcharts ret = new InformationClassEcharts();
        String echartData = informationClassMapper.getEchartData(id);
        if (echartData == null) {
            return null;
        }
        switch (type) {
            case "资源":
            case "活动":
                ret.setList(echartData);
                break;
            case "比赛":
                Integer startYear = informationClassMapper.getEchartStartYear(id);
                if (startYear == null) {
                    return null;
                } else {
                    ArrayList<String> years = new ArrayList<>();
                    int size = new Gson().fromJson(echartData,Integer[][].class).length;
                    for (int j = 0; j < size; j++) {
                        years.add(String.valueOf(j+startYear));
                    }
                    ret.setNameList(new Gson().toJson(years));
                }
                ret.setListGroup(echartData);
                break;
            case "部门":
                ret.setListGroup(echartData);
                break;
            default:
                throw new WrongDataException("错误的类型选择" + type);
        }
        return ret;
    }
}
