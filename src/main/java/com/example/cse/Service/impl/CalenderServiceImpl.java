package com.example.cse.Service.impl;

import com.example.cse.Dto.CalenderDto;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.UserClass.Calender;
import com.example.cse.Mapper.CalenderMapper;
import com.example.cse.Service.CalenderService;
import com.example.cse.Utils.CacheUtils;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Utils.Factory.CalenderDtoFactory;
import com.example.cse.Utils.Factory.ModelDtoFactory;
import com.example.cse.Vo.CalenderIn;
import com.example.cse.Vo.CalenderOut;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalenderServiceImpl implements CalenderService {

    @Autowired
    CalenderMapper calenderMapper;
    @Autowired
    CalenderDtoFactory factory;
    @Autowired
    ModelDtoFactory modelDtoFactory;
    @Autowired
    CacheUtils cacheUtils;

    @Override
    public CalenderOut getUserCalender(UserDto userDto) throws WrongDataException {
        CalenderOut calender = new CalenderOut();
        {
            List<Calender> calendersBefore = calenderMapper.getCalenderByUserBefore(userDto.getUid());
            List<CalenderDto<? super Object>> before = factory.getCalenderDtos(calendersBefore);
            calender.setBefore(before);
        }
        {
            List<Calender> calendersAfter = calenderMapper.getCalenderByUserAfter(userDto.getUid());
            List<CalenderDto<? super Object>> after = factory.getCalenderDtos(calendersAfter);
            calender.setAfter(after);
        }
        return calender;
    }

    @Override
    public Integer updateUserCalender(UserDto userDto, CalenderIn calenderIn) throws NoDataException {
        Calender calender = new Calender(calenderIn, userDto.getUid(), true);
        return calenderMapper.updateCalenderDescription(calender);
    }

    @Override
    public Integer deleteUserCalender(UserDto userDto, CalenderIn calenderIn) throws NoDataException {
        Calender calender = new Calender(calenderIn, userDto.getUid(), false);
        Integer integer = calenderMapper.updateCalenderDeprecated(calender);
        modelDtoFactory.calculateCalenderModel(userDto,-1,calender);
        cacheUtils.setCache("User",userDto.getUid().toString(),userDto);
        return integer;
    }

    @Override
    public Integer newUserCalender(UserDto userDto, CalenderIn calenderIn) throws NoDataException {
        if (!calenderIn.getRelationFunction().checkData()) {
            throw new  WrongDataException("错误的类型");
        }
        Calender calender = new Calender(calenderIn, userDto.getUid(), true);
        calender.setRelationFunction(new Gson().toJson(calenderIn.getRelationFunction()));
        Integer integer = calenderMapper.newCalender(calender);
        modelDtoFactory.calculateCalenderModel(userDto,1,calender);
        cacheUtils.setCache("User",userDto.getUid().toString(),userDto);
        return integer;
    }

}
