package com.example.cse.Service;

import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.ManagerConfig;
import com.example.cse.Vo.UserPass;

import java.util.List;

public interface ManagerService {
    boolean checkManager(UserPass userPass);

    ManagerConfig getConfig();

    boolean updateConfig(ManagerConfig managerConfig) throws WrongDataException;
}
