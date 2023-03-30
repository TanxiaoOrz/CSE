package com.example.cse.Utils.Factory;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Dto.ModelDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.Calender;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.*;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.ModelUtils;
import com.example.cse.Vo.TypeString;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;


@Component
public class ModelDtoFactory {
    @Autowired
    FavouriteMapper favouriteMapper;
    @Autowired
    CalenderMapper calenderMapper;
    @Autowired
    HobbyMapper hobbyMapper;
    @Autowired
    SurfMapper surfMapper;
    @Autowired
    ModelMapper modelMapper;

    @Value("${config.favourite}")
    private Integer favouriteScore;

    @Value("${config.calenderLong}")
    private Integer calenderLongScore;

    @Value("${config.calenderMiddle}")
    private Integer calenderMiddleScore;

    @Value("${config.calenderShort}")
    private Integer calenderShortScore;

    @Value("${config.surfMost}")
    private Integer surfScore;

    public List<ModelDto> createUserModel(User user) {
        ArrayList<ModelDto> modelDtos = new ArrayList<>();
        Calendar instance = Calendar.getInstance();
        int nowStudyYear = instance.get(Calendar.YEAR)  - (instance.get(Calendar.MONTH)<9? 0 :1);

        modelDtos.addAll(modelMapper.getModelByYear(nowStudyYear+1 - Integer.parseInt(user.getGrade())));
        modelDtos.addAll(modelMapper.getModelByProfession(user.getProfession()));

        user.setUserModel(new Gson().toJson(modelDtos));

        return modelDtos;
    }

    public void updateUserModel(UserDto userDto, User user) {
        for (ModelDto model:
                userDto.getUserModel()) {
            calculateModelDto(userDto,model,false);
        }
        userDto.setUserModel(createUserModel(user));

        for (ModelDto model:
                userDto.getUserModel()) {
            calculateModelDto(userDto,model,true);
        }

    }

    public void createSuggestionModel(UserDto userDto) throws WrongDataException {

        ConcurrentHashMap<Integer, Integer> keywordModels = new ConcurrentHashMap<>();
        userDto.setKeywordModels(keywordModels);
        calculateHobby(userDto);

        ConcurrentHashMap<Integer, Integer> messageModel = new ConcurrentHashMap<>();
        ConcurrentHashMap<Integer, Integer> informationClassModel = new ConcurrentHashMap<>();
        ConcurrentHashMap<Integer, Integer> locationModel = new ConcurrentHashMap<>();

        userDto.setMessageModel(messageModel);
        userDto.setLocationModels(locationModel);
        userDto.setInformationClassModel(informationClassModel);

        if (userDto.getUserModel() != null) {
            for (ModelDto model :
                    userDto.getUserModel()) {
                calculateModelDto(userDto, model, true);
            }
        }


        for (Integer mid:favouriteMapper.getFavouriteMidByUid(userDto.getUid())) {
            if (mid != null) {
                ModelUtils.addModel(messageModel, mid, favouriteScore);
            }

        }

        for (Integer cid:favouriteMapper.getFavouriteCidByUid(userDto.getUid())) {
            if (cid != null)
                ModelUtils.addModel(informationClassModel, cid, favouriteScore);
        }

        for (Integer lid:favouriteMapper.getFavouriteLidByUid(userDto.getUid())) {
            if (lid != null)
                ModelUtils.addModel(locationModel, lid, favouriteScore);
        }



        for (Calender calender:calenderMapper.getCalenderByUserAfter(userDto.getUid())) {
            calculateCalenderModel(userDto,1,calender);
        }

        Integer surfScore = this.surfScore;
        for (Integer mid:surfMapper.getSurfMostMessages(userDto.getUid())) {
            ModelUtils.addModel(messageModel,mid,surfScore);
            if (surfScore>0)
                surfScore--;
        }

        surfScore = this.surfScore;
        for (Integer lid:surfMapper.getSurfMostLocations(userDto.getUid())) {
            ModelUtils.addModel(messageModel,lid,surfScore);
            if (surfScore>0)
                surfScore--;
        }

        surfScore = this.surfScore;
        for (Integer cid:surfMapper.getSurfMostInformationClasses(userDto.getUid())) {
            ModelUtils.addModel(messageModel,cid,surfScore);
            if (surfScore>0)
                surfScore--;
        }

    }

    public void calculateHobby(UserDto userDto) {
        for (HobbyDto hobby: HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyByUserDegree(userDto.getUid(), "interested"))) {
            if (hobby.getModel() == null) {
                continue;
            }
            for (ModelDto model: hobby.getModel()) {
                calculateModelDto(userDto,model,true);
            }
        }
        for (HobbyDto hobby: HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyByUserDegree(userDto.getUid(), "uninterested"))) {
            if (hobby.getModel() == null) {
                continue;
            }
            for (ModelDto model: hobby.getModel()) {
                calculateModelDto(userDto,model,false);
            }
        }
    }

    public void calculateCalenderModel(UserDto userDto,Integer sign,Calender calender) throws WrongDataException {
        long compare = calender.getTime().getTime() - new Date().getTime();
        long day = 1000 * 60 * 60 * 24;
        long week = day * 7;
        if (compare<= day)
            addHobbyModel(userDto,calenderShortScore*sign,calender);
        else if (compare<= week)
            addHobbyModel(userDto,calenderMiddleScore*sign,calender);
        else
            addHobbyModel(userDto,calenderLongScore*sign, calender);
    }

    private void addHobbyModel(UserDto userDto,Integer score,Calender calender) throws WrongDataException {
        TypeString string = new Gson().fromJson(calender.getRelationFunction(), TypeString.class);
        switch (string.getType()){
            case "message":{
                ModelUtils.addModel(userDto.getMessageModel(),string.getId(),score);
                break;
            }
            case "informationClass":{
                ModelUtils.addModel(userDto.getInformationClassModel(),string.getId(),score);
                break;
            }
            case "location": {
                ModelUtils.addModel(userDto.getLocationModels(),string.getId(),score);
                break;
            }
            default: throw new WrongDataException("错误的RelationFunction存储,"
                    +"Calender: uid = "+calender.getUid()+", time = "+calender.getTime());
        }
    }

    private void calculateModelDto(UserDto userDto, ModelDto model, boolean add) {
        switch (model.getType()) {
            case "keyword" :
                ModelUtils.addModel(userDto.getKeywordModels(), model.getId(), model.getScore() * (add?1:-1));
                break;
            case "informationClass":
                ModelUtils.addModel(userDto.getInformationClassModel(), model.getId(), model.getScore() * (add?1:-1));
                break;
            case "location" :
                ModelUtils.addModel(userDto.getLocationModels(), model.getId(), model.getScore() * (add?1:-1));
                break;
        }
    }


}
