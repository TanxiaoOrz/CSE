package com.example.cse.Service.impl;

import com.example.cse.Dto.SurfCounts;
import com.example.cse.Dto.UserDto;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.Recommend.KeyAndType;
import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Entity.UserClass.User;
import com.example.cse.Mapper.*;
import com.example.cse.Service.UserService;
import com.example.cse.Utils.CacheUtils;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Factory.ModelDtoFactory;
import com.example.cse.Vo.*;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@Service
public class UserServiceImpl implements UserService{

    @Autowired
    UserMapper userMapper;
    @Autowired
    ProfessionMapper professionMapper;
    @Autowired
    HobbyMapper hobbyMapper;
    @Autowired
    CacheUtils cacheUtils;
    @Autowired
    ModelDtoFactory modelDtoFactory;
    @Autowired
    SurfMapper surfMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    LocationMapper locationMapper;

    @Override
    public UserDto getUserByNamePass(UserPass userPass) throws NoDataException{
        userPass.checkNull();
        User user = userMapper.getUserByNamePass(userPass);
        if (user == null) {
            return null;
        }
        UserDto userDto = new UserDto(user, professionMapper);
        modelDtoFactory.createSuggestionModel(userDto);
        return userDto;
    }

    @Override
    public UserDto getUserByUid(String uid) throws NoDataException {
        if (StringUtils.hasText(uid)) {
            User user = userMapper.getUserByUid(uid);
            if (user == null) {
                throw new NoDataException(Vo.WrongPostParameter,"token包含未知Uid");
            }
            UserDto userDto = new UserDto(user, professionMapper);
            cacheUtils.setCache("User",uid,userDto);
            return userDto;
        }
        throw new NoDataException(Vo.WrongPostParameter,"token没有Uid");
    }

    @Override
    public Integer newUser(UserCreate userCreate) throws NoDataException {
        userCreate.checkNull(professionMapper,userMapper);
        if (userMapper.checkUserExist(userCreate.getUserCode())==0) {
            User newUser = new User(userCreate);
            modelDtoFactory.createUserModel(newUser);
            return userMapper.newUser(newUser);
        }else
            throw new NoDataException(Vo.WrongPostParameter,"该学号已存在");
    }

    @Override
    public Integer updateUser(UserBasic newUser, UserDto oldUser) throws NoDataException{
        newUser.check();

        User user = new User();
        boolean empty = false;
        if (newUser.getUid().equals(oldUser.getUid()))
            user.setUid(newUser.getUid());
        else
            throw new NoDataException(Vo.WrongPostParameter,"修改的Uid与登录Uid不一致");
        if (StringUtils.hasText(newUser.getUserName())&&!Objects.equals(newUser.getUserName(), oldUser.getUserName())){
            user.setUserName(newUser.getUserName());
            oldUser.setUserName(newUser.getUserName());
            empty = true;
        }else
            user.setUserName(oldUser.getUserName());
        if (StringUtils.hasText(newUser.getSex())&&!Objects.equals(newUser.getSex(), oldUser.getSex())){
            user.setSex(newUser.getSex());
            oldUser.setSex(newUser.getSex());
            empty = true;
        }else
            user.setSex(oldUser.getSex());
        if (newUser.getProfession()!=null&&!Objects.equals(newUser.getProfession(), oldUser.getProfession().getPid())){
            user.setProfession(newUser.getProfession());
            Profession profession = professionMapper.getProfessionByPid(newUser.getProfession());
            if (profession == null) {
                throw new NoDataException(Vo.WrongPostParameter,"错误的专业序号");
            }
            oldUser.setProfession(profession);
            empty = true;
        }else
            user.setProfession(oldUser.getProfession().getPid());
        if (StringUtils.hasText(newUser.getGrade())&&!Objects.equals(newUser.getGrade(), oldUser.getGrade())){
            user.setGrade(newUser.getGrade());
            oldUser.setGrade(newUser.getGrade());
            empty = true;
        }else
            user.setGrade(oldUser.getGrade());
        if (!empty)
            throw new NoDataException(Vo.WrongPostParameter,"没有进行更改");

        modelDtoFactory.updateUserModel(oldUser,user);
        Integer integer =userMapper.updateUser(user);

        cacheUtils.setCache("User",oldUser.getUid().toString(),oldUser);

        return integer;
    }


    @Override
    public SurfMost getUserSurfMost(UserDto userDto) {

        List<Integer> informationClassCounts = new ArrayList<>();
        List<Integer> locationCounts = new ArrayList<>();
        List<Integer> keyCounts = new ArrayList<>();

        List<InformationClass> informationClasses = new ArrayList<>();
        List<Location> locations = new ArrayList<>();
        List<KeyAndType> keyAndTypes = new ArrayList<>();

        List<SurfCounts> keysCounts = surfMapper.getSurfMostKeysCounts(userDto.getUid());

        for (SurfCounts key:
             keysCounts) {
            keyCounts.add(key.getCounts());
            keyAndTypes.add(keyTypeMapper.getKeyAndTypeByKid(key.getId()));
        }

        List<SurfCounts> locationsCounts = surfMapper.getSurfMostLocationsCounts(userDto.getUid());

        for (SurfCounts location:
                locationsCounts) {
            locationCounts.add(location.getCounts());
            locations.add(locationMapper.getLocationByRule(location.getId(),null).get(0));
        }

        List<SurfCounts> informationClassesCounts = surfMapper.getSurfMostInformationClassesCounts(userDto.getUid());

        for (SurfCounts informationClass:
                informationClassesCounts) {
            informationClassCounts.add(informationClass.getCounts());
            informationClasses.add(informationClassMapper.getInformationClassByRule(informationClass.getId(),null,null).get(0));
        }
        return new SurfMost(informationClassCounts,locationCounts,keyCounts,informationClasses,locations,keyAndTypes);
    }


}
