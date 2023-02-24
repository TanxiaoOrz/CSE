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

    public void createUserModel(UserDto userDto) throws WrongDataException {

        HashMap<Integer, Integer> keywordModels = new HashMap<>();
        userDto.setKeywordModels(keywordModels);
        calculateHobby(userDto);


        HashMap<Integer, Integer> messageModel = new HashMap<>();
        for (Integer mid:favouriteMapper.getFavouriteMidByUid(userDto.getUid())) {
            ModelUtils.addModel(messageModel, mid, 1);
        }
        HashMap<Integer, Integer> informationClassModel = new HashMap<>();
        for (Integer cid:favouriteMapper.getFavouriteCidByUid(userDto.getUid())) {
            ModelUtils.addModel(informationClassModel, cid, 1);
        }
        HashMap<Integer, Integer> locationModel = new HashMap<>();
        for (Integer lid:favouriteMapper.getFavouriteLidByUid(userDto.getUid())) {
            ModelUtils.addModel(locationModel, lid, 1);
        }

        Date now = new Date();
        long day = 1000*60*60*24;
        long week = day*7;

        for (Calender calender:calenderMapper.getCalenderByUserAfter(userDto.getUid())) {
            int compare = calender.getTime().compareTo(now);
            if (compare<=day)
                addHobbyModel(userDto,3,calender);
            else if (compare<=week)
                    addHobbyModel(userDto,2,calender);
                else
                    addHobbyModel(userDto,1, calender);
        }

        userDto.setMessageModel(messageModel);
        userDto.setLocationModels(locationModel);
        userDto.setInformationClassModel(informationClassModel);
    }

    public void calculateHobby(UserDto userDto) {
        for (HobbyDto hobby: HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyByUserDegree(userDto.getUid(), "interested"))) {
            for (ModelDto model: hobby.getModel()) {
                ModelUtils.addModel(userDto.getKeywordModels(), model.getId(), model.getScore());
            }
        }
        for (HobbyDto hobby: HobbyDto.createHobbyDtoList(hobbyMapper.getHobbyByUserDegree(userDto.getUid(), "uninterested"))) {
            for (ModelDto model: hobby.getModel()) {
                ModelUtils.addModel(userDto.getKeywordModels(), model.getId(), -model.getScore());
            }
        }
    }

    private void addHobbyModel(UserDto userDto,Integer score,Calender calender) throws WrongDataException {
        TypeString string = new Gson().fromJson(calender.getRelationFunction(), TypeString.class);
        switch (string.getType()){
            case "message":{
                ModelUtils.addModel(userDto.getMessageModel(),string.getId(),score);

            }
            case "informationClass":{
                ModelUtils.addModel(userDto.getMessageModel(),string.getId(),score);
            }
            case "location": {
                ModelUtils.addModel(userDto.getMessageModel(),string.getId(),score);
            }
            default: throw new WrongDataException("错误的RelationFunction存储,"
                    +"Calender: uid = "+calender.getUid()+", time = "+calender.getTime());
        }
    }

}
