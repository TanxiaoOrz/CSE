package com.example.cse.Service.impl;

import com.example.cse.Service.ManagerService;
import com.example.cse.Vo.UserPass;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Value("${manager.managerName}")
    String managerName;

    @Value("${manager.managerPass}")
    String managerPass;


    @Override
    public boolean checkManager(UserPass userPass) {
        return userPass.getUserCode().equals(managerName)&&userPass.getUserPass().equals(managerPass);
    }

}
