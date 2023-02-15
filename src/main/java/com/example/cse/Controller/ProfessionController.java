package com.example.cse.Controller;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Service.impl.ProfessionServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.ProfessionIn;
import com.example.cse.Vo.out.Vo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/cse/Profession")
public class ProfessionController {

    @Autowired
    ProfessionServiceImpl professionService;

    //尚未增加权限监测
    @PostMapping
    public Vo<String> newProfession(@RequestBody ProfessionIn profession) throws NoDataException {
        Integer integer = professionService.newProfession(profession);
        if (integer == 1)
            return new Vo<>(Vo.Success,"专业创建成功",null);
        else
            return new Vo<>(Vo.WrongPostParameter,null,"未知错误");
    }

    @PostMapping("/all")
    public Vo<List<Profession>> getProfessionAll(){
        return new Vo<>(Vo.Success,professionService.getProfessionAll(),null) ;
    }


}
