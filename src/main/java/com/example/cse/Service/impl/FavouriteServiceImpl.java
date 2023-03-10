package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Mapper.FavouriteMapper;
import com.example.cse.Mapper.KeyTypeMapper;
import com.example.cse.Mapper.MessageMapper;
import com.example.cse.Service.FavouriteService;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.ModelUtils;
import com.example.cse.Vo.FavouriteInformationClass;
import com.example.cse.Vo.FavouriteLocation;
import com.example.cse.Vo.FavouriteMessage;
import com.example.cse.Vo.FavouriteOut;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavouriteServiceImpl implements FavouriteService {


    @Autowired
    FavouriteMapper favouriteMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Autowired
    MessageMapper messageMapper;

    @Override
    public FavouriteOut getFavouriteByUser(UserDto userDto) {
        List<FavouriteLocation> locations = favouriteMapper.getFavouriteLocationByUser(userDto.getUid());
        List<FavouriteMessage> messages = favouriteMapper.getFavouriteMessageByUser(userDto.getUid());
        for (FavouriteMessage message:messages) {
            message.setType(messageMapper.getMessageClassType(message.getMid()));
        }
        List<FavouriteInformationClass> informationClasses = favouriteMapper.getFavouriteInformationClassByUser(userDto.getUid());
        for (FavouriteInformationClass informationClass:informationClasses){
            informationClass.setKeys(keyTypeMapper.getKeyAndTypeByCid(informationClass.getCid()));
        }

        return new FavouriteOut(informationClasses,locations,messages);
    }

    @Override
    public Integer deleteFavourite(UserDto userDto, Integer id, String type) throws NoDataException {
        Integer integer;
        switch (type){
            case "message" : {
                integer = favouriteMapper.deleteFavouriteMessage(userDto.getUid(), id);
                ModelUtils.addModel(userDto.getMessageModel(), id, -1);
                break;
            }
            case "location" : {
                integer = favouriteMapper.deleteFavouriteLocation(userDto.getUid(), id);
                ModelUtils.addModel(userDto.getLocationModels(), id, -1);
                break;
            }
            case "informationClass" : {
                integer = favouriteMapper.deleteFavouriteInformationClass(userDto.getUid(), id);
                ModelUtils.addModel(userDto.getInformationClassModel(), id, -1);
                break;
            }
            default:
                throw new NoDataException("错误的Type字段");
        }
        return integer;
    }

    @Override
    public Integer deleteFavouriteNull(UserDto userDto, String type) throws NoDataException {
        Integer integer;
        switch (type){
            case "message" : {
                integer = favouriteMapper.deleteFavouriteMessage(userDto.getUid());
                break;
            }
            case "location" : {
                integer = favouriteMapper.deleteFavouriteLocation(userDto.getUid());
                break;
            }
            case "informationClass" : {
                integer = favouriteMapper.deleteFavouriteInformationClass(userDto.getUid());
                break;
            }
            default:
                throw new NoDataException("错误的Type字段");
        }
        return integer;
    }

    @Override
    public Integer newFavourite(UserDto userDto, Integer id, String type) throws NoDataException {
        Integer integer;
        switch (type){
            case "message" : {
                integer = favouriteMapper.newFavouriteMessage(userDto.getUid(), id);
                ModelUtils.addModel(userDto.getMessageModel(), id, 1);
                break;
            }
            case "location" : {
                integer = favouriteMapper.newFavouriteLocation(userDto.getUid(), id);
                ModelUtils.addModel(userDto.getLocationModels(), id, 1);
                break;
            }
            case "informationClass" : {
                integer = favouriteMapper.newFavouriteInformationClass(userDto.getUid(), id);
                ModelUtils.addModel(userDto.getInformationClassModel(), id, 1);
                break;
            }
            default:
                throw new NoDataException("错误的Type字段");
        }
        return integer;
    }
}
