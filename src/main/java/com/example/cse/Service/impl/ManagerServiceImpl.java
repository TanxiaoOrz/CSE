package com.example.cse.Service.impl;

import com.example.cse.Dto.SurfCounts;
import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.Recommend.KeyAndType;
import com.example.cse.Mapper.*;
import com.example.cse.Service.ManagerService;
import com.example.cse.Task.CalculateTask;
import com.example.cse.Task.DeleteTask;
import com.example.cse.Task.EndOpenTask;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.ManagerConfig;
import com.example.cse.Vo.SurfMost;
import com.example.cse.Vo.UserPass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Value("${manager.managerName}")
    String managerName;

    @Value("${manager.managerPass}")
    String managerPass;
    @Autowired
    CalculateTask calculateTask;
    @Autowired
    DeleteTask deleteTask;
    @Autowired
    EndOpenTask endOpenTask;
    @Autowired
    SurfMapper surfMapper;
    @Autowired
    InformationClassMapper informationClassMapper;
    @Autowired
    LocationMapper locationMapper;
    @Autowired
    KeyTypeMapper keyTypeMapper;


    @Override
    public boolean checkManager(UserPass userPass) {
        return userPass.getUserCode().equals(managerName)&&userPass.getUserPass().equals(managerPass);
    }

    @Override
    public ManagerConfig getConfig() {
        ManagerConfig managerConfig = new ManagerConfig();
        managerConfig.setCalculateDegree(calculateTask.getCalculateDegree());
        managerConfig.setCalculateEnabled(calculateTask.isCalculateEnabled());
        managerConfig.setSleepEnabled(endOpenTask.isSleepEnabled());
        managerConfig.setDeleteEnabled(deleteTask.isDeleteEnabled());
        return managerConfig;
    }

    @Override
    public boolean updateConfig(ManagerConfig managerConfig) throws WrongDataException {
        boolean updated = false;
        managerConfig.checkValue();
        if (managerConfig.getSleepEnabled() != endOpenTask.isSleepEnabled()) {
            endOpenTask.setSleepEnabled(managerConfig.getSleepEnabled());
            updated = true;
        }
        if (managerConfig.getSleepEnabled()) {
            if (managerConfig.getDeleteEnabled() != deleteTask.isDeleteEnabled()) {
                deleteTask.setDeleteEnabled(managerConfig.getDeleteEnabled());
                updated = true;
            }
            if (managerConfig.getCalculateEnabled() != (calculateTask.isCalculateEnabled())) {
                calculateTask.setCalculateEnabled(managerConfig.getCalculateEnabled());
                updated = true;
            }
            if (managerConfig.getCalculateDegree() != calculateTask.getCalculateDegree()) {
                calculateTask.setCalculateDegree(managerConfig.getCalculateDegree());
                updated = true;
            }
        }

        return updated;
    }

    @Override
    public SurfMost getSurfMost() {
        List<Integer> informationClassCounts = new ArrayList<>();
        List<Integer> locationCounts = new ArrayList<>();
        List<Integer> keyCounts = new ArrayList<>();
        List<InformationClass> informationClasses = new ArrayList<>();
        List<Location> locations = new ArrayList<>();
        List<KeyAndType> keyAndTypes = new ArrayList<>();

        List<SurfCounts> keysCounts = surfMapper.getSurfMostKeysCountsAll();

        for (SurfCounts key:
                keysCounts) {
            keyCounts.add(key.getCounts());
            keyAndTypes.add(keyTypeMapper.getKeyAndTypeByKid(key.getId()));
        }

        List<SurfCounts> locationsCounts = surfMapper.getSurfMostLocationsCountsAll();

        for (SurfCounts location:
                locationsCounts) {
            locationCounts.add(location.getCounts());
            locations.add(locationMapper.getLocationByRule(location.getId(),null).get(0));
        }

        List<SurfCounts> informationClassesCounts = surfMapper.getSurfMostInformationClassesCountsAll();

        for (SurfCounts informationClass:
                informationClassesCounts) {
            informationClassCounts.add(informationClass.getCounts());
            informationClasses.add(informationClassMapper.getInformationClassByRule(informationClass.getId(),null,null).get(0));
        }
        return new SurfMost(informationClassCounts,locationCounts,keyCounts,informationClasses,locations,keyAndTypes);
    }


}
