package com.example.cse.Service.impl;

import com.example.cse.Dto.BasicModelDto;
import com.example.cse.Dto.HobbyDto;
import com.example.cse.Dto.ModelDto;
import com.example.cse.Mapper.*;
import com.example.cse.Service.ModelService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ModelServiceImpl implements ModelService {

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    HobbyMapper hobbyMapper;
    @Autowired
    UserMapper userMapper;
    @Autowired
    SurfMapper surfMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Autowired
    ProfessionMapper professionMapper;
    @Autowired
    ModelMapper modelMapper;

    @Value("${config.hobbyLow}")
    Integer hobbyLow;
    @Value("${config.hobbyMiddle}")
    Integer hobbyMiddle;
    @Value("${config.hobbyHigh}")
    Integer hobbyHigh;
    @Value("${config.modelEffective}")
    Float modelEffective;

    static class RankObject<T> implements Comparable<RankObject<?>>{
        T owner;
        ModelDto model;
        Float score;

        public RankObject(T hobby, ModelDto model, Float score) {
            this.owner = hobby;
            this.model = model;
            this.score = score;
        }


        @Override
        public int compareTo(RankObject o) {
            return score.compareTo(o.score);
        }
    }


    @Override
    public void calculateHobbyModel() {
        List<HobbyDto> hobbies = HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyAll());
        List<RankObject<HobbyDto>> rankKey = new ArrayList<>();
        List<RankObject<HobbyDto>> rankInformation = new ArrayList<>();
        logger.info("开始计算爱好模型分数");
        int i = 0;
        int all = hobbies.size();
        for (HobbyDto hobby:
             hobbies) {
            if (hobby.getModel() == null) {
                break;
            }
            List<Integer> userInterested = userMapper.getUidsByHobby(hobby.getHid(),"interested");
            Integer surfInterestA =userInterested.size()== 0? 0: surfMapper.getCountKeyByUser(userInterested,null);
            for (ModelDto model:
                    hobby.getModel()) {
                buildupRankList(hobby, rankKey, rankInformation, userInterested, surfInterestA, model);
            }
            logger.info("计算爱好模型进度："+(++i)+" / "+all);
        }
        logger.info("开始排序");
        Collections.sort(rankKey);
        Collections.sort(rankInformation);
        Set<HobbyDto> hobbiesToUpdate = new HashSet<>();
        logger.info("开始打分");
        updateModels(rankKey, hobbiesToUpdate);
        updateModels(rankInformation,hobbiesToUpdate);
        Gson gson = new Gson();
        logger.info("开始更新");
        hobbiesToUpdate.forEach(e->hobbyMapper.updateHobbyModel(e.getHid(),gson.toJson(e.getModel())));

    }



    @Override
    public void regenerateHobbyModel() {
        List<HobbyDto> hobbies = HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyAll());
        List<RankObject<HobbyDto>> rankKey = new ArrayList<>();
        List<Integer> kids = keyTypeMapper.getKidsAll();
        logger.info("开始重新生成爱好模型");
        int i = 0;
        int all = hobbies.size();
        for (HobbyDto hobby:
                hobbies) {

            List<Integer> userInterested = userMapper.getUidsByHobby(hobby.getHid(),"interested");
            List<Integer> userCommon = userMapper.getUidsByHobby(hobby.getHid(),"common");
            List<Integer> userUninterested = userMapper.getUidsByHobby(hobby.getHid(),"uninterested");

            for (Integer kid:
                 kids) {
                int surfInterestedK =userInterested.size()==0?0: surfMapper.getCountKeyByUser(userInterested, kid);
                float surfCommonK =userCommon.size()==0?0: surfMapper.getCountKeyByUser(userCommon, kid);
                int surfUninterestedK =userUninterested.size()==0?0: surfMapper.getCountKeyByUser(userUninterested, kid);
                if (
                        ((surfInterestedK/((float) userInterested.size()+1))+(surfUninterestedK/((float) userUninterested.size()+1)))
                        /((surfCommonK/(float) userCommon.size()+1)+1)
                                >modelEffective
                ) {
                    ModelDto model = new ModelDto();
                    model.setType("keyword");
                    model.setId(kid);
                    Integer surfInterestA =userInterested.size()==0?0: surfMapper.getCountKeyByUser(userInterested,null);
                    rankKey.add(new RankObject<>(hobby, model, (surfInterestedK /(float) (surfInterestA+1))));
                }
                logger.info("有效行计算进度："+ (++i) +" / "+all);
            }
            logger.info("开始排序");
            Collections.sort(rankKey);
            logger.info("开始打分");
            Set<HobbyDto> hobbiesToUpdate = new HashSet<>();
            updateModels(rankKey, hobbiesToUpdate);
            Gson gson = new Gson();
            logger.info("开始更新");
            hobbiesToUpdate.forEach(e->hobbyMapper.updateHobbyModel(e.getHid(), gson.toJson(e.getModel())));

        }

    }

    @Override
    public void calculateBasicModelScore() {
        List<Integer> pids = professionMapper.getPidAll();
        List<RankObject<BasicModelDto>> rankKey = new ArrayList<>();
        List<RankObject<BasicModelDto>> rankInformation = new ArrayList<>();
        logger.info("开始重新生成专业模型");
        for (Integer pid : pids) {
            List<BasicModelDto> modelDtos = modelMapper.getBasicModelByProfession(pid);
            if (modelDtos.isEmpty()) {
                break;
            }
            List<Integer> userIn = userMapper.getUidsByPid(pid);
            Integer surfInterestA =userIn.size()==0?0: surfMapper.getCountKeyByUser(userIn,null);
            for (BasicModelDto model:
                    modelDtos) {
                buildupRankList(model, rankKey, rankInformation, userIn,surfInterestA,model);
            }
        }
        logger.info("开始排序");
        Collections.sort(rankKey);
        Collections.sort(rankInformation);
        Set<BasicModelDto> basicToUpdate = new HashSet<>();
        updateModels(rankKey, basicToUpdate);
        updateModels(rankInformation,basicToUpdate);

        rankKey.clear();
        rankInformation.clear();

        logger.info("开始重新生成年级模型");
        Calendar instance = Calendar.getInstance();
        int nowStudyYear = instance.get(Calendar.YEAR)  - (instance.get(Calendar.MONTH)<9 ? 0 :1);
        for (int year = 0; year < 4; year++) {

            List<BasicModelDto> modelDtos = modelMapper.getBasicModelByYear(year);
            if (modelDtos.isEmpty()) {
                break;
            }
            List<Integer> userIn = userMapper.getUidsByYear(String.valueOf(nowStudyYear-year));
            Integer surfInterestA =userIn.size()==0?0: surfMapper.getCountKeyByUser(userIn,null);
            for (BasicModelDto model:
                    modelDtos) {
                buildupRankList(model, rankKey, rankInformation, userIn,surfInterestA,model);
            }

        }
        logger.info("开始排序");
        Collections.sort(rankKey);
        Collections.sort(rankInformation);

        updateModels(rankKey, basicToUpdate);
        updateModels(rankInformation,basicToUpdate);
        logger.info("开始更新");
        basicToUpdate.forEach(modelMapper::updateBasicModels);

    }

    private<T> void buildupRankList(T t, List<RankObject<T>> rankKey, List<RankObject<T>> rankInformationClass, List<Integer> userValue, Integer surfInterestA, ModelDto model) {
        Integer surfInterestedK;
        switch (model.getType()) {
            case "keyword":
                surfInterestedK =userValue.size()==0? 0: surfMapper.getCountKeyByUser(userValue, model.getId());
                rankKey.add(new RankObject<>(t, model, surfInterestedK /((float) surfInterestA + 1)));
                break;
            case "informationClass":
                surfInterestedK =userValue.size()==0? 0: surfMapper.getCountKeyByUser(userValue, model.getId());
                rankInformationClass.add(new RankObject<>(t, model, surfInterestedK /((float) surfInterestA + 1)));
                break;
        }
    }

    private<T> void updateModels(List<RankObject<T>> rankKey, Set<T> modelsToUpdate) {
        int count = rankKey.size();
        int rank = 0;
        for (RankObject<T> rankObject:
                rankKey) {
            Integer score = getScore(rank,count);
            rank++;

            if (Objects.equals(score, rankObject.model.getScore())) {
                break;
            }
            rankObject.model.setScore(score);
            modelsToUpdate.add(rankObject.owner);
        }
    }

    private Integer getScore(Integer rank, Integer count) {
        if (rank<count/3)
            return hobbyLow;
        else if (rank<count/3*2)
            return hobbyMiddle;
        else
            return hobbyHigh;
    }

}
