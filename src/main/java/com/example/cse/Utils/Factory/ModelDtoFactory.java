package com.example.cse.Utils.Factory;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Dto.ModelDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.Calender;
import com.example.cse.Mapper.CalenderMapper;
import com.example.cse.Mapper.FavouriteMapper;
import com.example.cse.Mapper.HobbyMapper;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.ModelUtils;
import com.example.cse.Utils.TypeString;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import java.util.Date;
import java.util.HashMap;


@Component
public class ModelDtoFactory {
    @Autowired
    FavouriteMapper favouriteMapper;
    @Autowired
    CalenderMapper calenderMapper;
    @Autowired
    HobbyMapper hobbyMapper;
    private final long day = 1000*60*60*24;
    private final long week = day*7;

    @Value("${config.favourite}")
    private Integer favouriteScore;

    @Value("${config.calenderLong}")
    private Integer calenderLongScore;

    @Value("${config.calenderMiddle}")
    private Integer calenderMiddleScore;

    @Value("${config.calenderShort}")
    private Integer calenderShortScore;

    public void createUserModel(UserDto userDto) throws WrongDataException {

        HashMap<Integer, Integer> keywordModels = new HashMap<>();
        userDto.setKeywordModels(keywordModels);
        calculateHobby(userDto);

        HashMap<Integer, Integer> messageModel = new HashMap<>();
        HashMap<Integer, Integer> informationClassModel = new HashMap<>();
        HashMap<Integer, Integer> locationModel = new HashMap<>();

        userDto.setMessageModel(messageModel);
        userDto.setLocationModels(locationModel);
        userDto.setInformationClassModel(informationClassModel);


        for (Integer mid:favouriteMapper.getFavouriteMidByUid(userDto.getUid())) {
            ModelUtils.addModel(messageModel, mid, favouriteScore);
        }

        for (Integer cid:favouriteMapper.getFavouriteCidByUid(userDto.getUid())) {
            ModelUtils.addModel(informationClassModel, cid, favouriteScore);
        }

        for (Integer lid:favouriteMapper.getFavouriteLidByUid(userDto.getUid())) {
            ModelUtils.addModel(locationModel, lid, favouriteScore);
        }



        for (Calender calender:calenderMapper.getCalenderByUserAfter(userDto.getUid())) {
            calculateCalenderModel(userDto,1,calender);
        }


    }

    public void calculateHobby(UserDto userDto) {
        for (HobbyDto hobby: HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyByUserDegree(userDto.getUid(), "interested"))) {
            if (hobby.getModel() == null) {
                continue;
            }
            for (ModelDto model: hobby.getModel()) {
                ModelUtils.addModel(userDto.getKeywordModels(), model.getId(), model.getScore());
            }
        }
        for (HobbyDto hobby: HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyByUserDegree(userDto.getUid(), "uninterested"))) {
            if (hobby.getModel() == null) {
                continue;
            }
            for (ModelDto model: hobby.getModel()) {
                ModelUtils.addModel(userDto.getKeywordModels(), model.getId(), -model.getScore());
            }
        }
    }

    public void calculateCalenderModel(UserDto userDto,Integer sign,Calender calender) throws WrongDataException {
        int compare = calender.getTime().compareTo(new Date());
        if (compare<=day)
            addHobbyModel(userDto,calenderShortScore,calender);
        else if (compare<=week)
            addHobbyModel(userDto,calenderMiddleScore,calender);
        else
            addHobbyModel(userDto,calenderLongScore, calender);
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

}
