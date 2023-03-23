package com.example.cse.Service.impl;

import com.example.cse.Dto.UserDto;
import com.example.cse.Mapper.SurfMapper;
import com.example.cse.Service.SurfService;
import com.example.cse.Utils.Exception.WrongDataException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SurfServiceImpl implements SurfService {
    @Autowired
    SurfMapper surfMapper;

    @Override
    public Integer newSurf(UserDto userDto, Integer id, Integer type) throws WrongDataException {
        if (userDto == null)
            return newSurf(id,type);
        else {
            switch (type) {
                case SurfService.MESSAGE:
                    return surfMapper.newMessageSurf(userDto.getUid(), id);
                case SurfService.LOCATION:
                    return surfMapper.newLocationSurf(userDto.getUid(), id);
                case SurfService.INFORMATION_CLASS:
                    return surfMapper.newInformationSurf(userDto.getUid(), id);
                default:
                    throw new WrongDataException("错误的类型请求，请联系管理员");
            }
        }
    }

    @Override
    public Integer newSurf(Integer id, Integer type) throws WrongDataException {
        switch (type) {
            case SurfService.MESSAGE:
                return surfMapper.newMessageSurf(null, id);
            case SurfService.LOCATION:
                return surfMapper.newLocationSurf(null, id);
            case SurfService.INFORMATION_CLASS:
                return surfMapper.newInformationSurf(null, id);
            default:
                throw new WrongDataException("错误的类型请求，请联系管理员");
        }
    }


    @Override
    public List<Integer> getSurfRank(UserDto userDto, Integer type) {
        return null;
    }
}
