package com.example.cse.Service.impl;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.Recommend.Hobby;
import com.example.cse.Mapper.HobbyMapper;
import com.example.cse.Service.HobbyService;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.HobbyIn;
import com.example.cse.Vo.UserHobbyIn;
import com.example.cse.Vo.Vo;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HobbyServiceImpl implements HobbyService {
    @Autowired
    HobbyMapper hobbyMapper;

    @Override
    public Integer newHobby(HobbyIn hobbyIn) throws NoDataException {
        Hobby hobby =new Hobby();
        hobby.setName(hobby.getName());
        if (hobbyMapper.getHobbyByRule(hobby)==null) {
            hobby.setDescription(hobbyIn.getDescription());
            hobby.setType(hobbyIn.getType());
            hobby.setModel(new Gson().toJson(hobbyIn.getModel()));
            return hobbyMapper.newHobby(hobby);
        }else {
            throw new NoDataException(Vo.WrongPostParameter,"同名爱好已存在");
        }

    }

    @Override
    public List<HobbyDto> getHobbyAll() {
        List<Hobby> hobbyAll = hobbyMapper.getHobbyAll();
        return HobbyDto.createHobbyDtoList(hobbyAll);
    }

    @Override
    public List<HobbyDto> getHobbyByUserDegree(UserDto userDto, String degree) {
        List<Hobby> hobbies = hobbyMapper.getHobbyByUserDegree(userDto.getUid(),degree);
        return HobbyDto.createHobbyDtoList(hobbies);
    }

    @Override
    public Integer updateUserHobby(UserHobbyIn userHobby, UserDto userDto) throws NoDataException{
        userHobby.checkNull();

        Hobby hobby = new Hobby();
        hobby.setHid(userHobby.getHid());

        if (hobbyMapper.getHobbyByRule(hobby) == null) {
            throw new NoDataException("不存在该Hid的爱好");
        }

        return hobbyMapper.updateUserHobby(userDto.getUid(), userHobby.getHid(), userHobby.getDegree());
    }
}
