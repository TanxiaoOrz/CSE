package com.example.cse.Service.impl;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Mapper.ProfessionMapper;
import com.example.cse.Service.ProfessionService;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.ProfessionIn;
import com.example.cse.Vo.Vo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfessionServiceImpl implements ProfessionService {
    @Autowired
    ProfessionMapper professionMapper;

    @Override
    public Integer newProfession(ProfessionIn profession) throws NoDataException {
        profession.checkNull();
        Integer exist = professionMapper.checkProfessionExist(null, profession.getProfessionName());
        if (exist==1)
            throw new NoDataException(Vo.WrongPostParameter,"已存在该专业："+profession.getProfessionName());
        return professionMapper.newProfession(profession);
    }

    @Override
    public Profession getProfessionByPid(int Pid) {
        return professionMapper.getProfessionByPid(Pid);
    }

    @Override
    public List<Profession> getProfessionAll() {
        return professionMapper.getProfessionAll();
    }
}
