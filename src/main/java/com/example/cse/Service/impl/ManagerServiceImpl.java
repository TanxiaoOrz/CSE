package com.example.cse.Service.impl;

import com.example.cse.Service.ManagerService;
import com.example.cse.Task.CalculateTask;
import com.example.cse.Task.DeleteTask;
import com.example.cse.Task.EndOpenTask;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.ManagerConfig;
import com.example.cse.Vo.UserPass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

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


}
