package com.example.cse.Service;


import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.ProfessionIn;

import java.util.List;

public interface ProfessionService {

    Integer newProfession(ProfessionIn profession) throws NoDataException;

    Profession getProfessionByPid(int Pid);

    List<Profession> getProfessionAll();
}
