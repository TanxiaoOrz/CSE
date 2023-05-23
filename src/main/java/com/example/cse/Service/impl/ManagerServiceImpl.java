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
import com.example.cse.Vo.TimeSurfInformationClass;
import com.example.cse.Vo.UserPass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;

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

    @Override
    public TimeSurfInformationClass getTimeChangeSurfInformationClass() {
        TimeSurfInformationClass ret = new TimeSurfInformationClass();
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DATE,-7);
        List<String> timeName = new ArrayList<>(7);
        List<List<Integer>> surfTimes = new ArrayList<>(7);
        List<InformationClass> informationClasses = informationClassMapper.getInformationClassByRule(null,null,null);
        for (int i = 6; i >= 0; i--) {
            timeName.add(calendar.getTime().toString());
            calendar.add(Calendar.DATE,1);
            List<Integer> surfOfDay = new ArrayList<>(informationClasses.size());
            List<SurfCounts> surfCountsList = surfMapper.getSurfTimesInformationClassInDaysBefore(i);
            if (surfCountsList.size()==0) {
                for (int j = 0; j < informationClasses.size(); j++) {
                    surfOfDay.add(0);
                }
            }
            surfCountsList.forEach(surfCounts -> {
                while (surfOfDay.size()<surfCounts.getId()-1) {
                    surfOfDay.add(0);
                }
                surfOfDay.add(surfCounts.getCounts());
            });
            surfTimes.add(surfOfDay);
        }
        ret.setInformationClasses(informationClasses);
        ret.setSurfTimes(surfTimes);
        ret.setTimeName(timeName);
        return ret;
    }

    @Override
    public List<List<Integer>> getSurfTime() {
        Calendar calendar = Calendar.getInstance();
        int i = calendar.get(Calendar.DAY_OF_WEEK);
        ArrayList<List<Integer>> ret = new ArrayList<>(7*24);
        for (int weekDay = 0; weekDay < 7; weekDay++) {
            for (int hour = 0; hour < 24; hour++) {
                ArrayList<Integer> hourGroup = new ArrayList<>(3);
                int length =(7 + i - weekDay) % 7;
                hourGroup.add(weekDay);
                hourGroup.add(hour);
                Integer times = surfMapper.getSurfTimesInDaysBefore(length, hour);
                if (times==0)
                    hourGroup.add(0);
                else {
                    hourGroup.add((int) Math.log(times));
                }
                ret.add(hourGroup);
            }
        }
        return ret;
    }


}
