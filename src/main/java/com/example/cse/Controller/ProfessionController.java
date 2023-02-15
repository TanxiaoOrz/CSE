package com.example.cse.Controller;

import com.example.cse.Entity.UserClass.Profession;
import com.example.cse.Service.impl.ProfessionServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.in.ProfessionIn;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@Api(tags = "Profession接口",description = "只有新建需要manager验证")
@RequestMapping("/cse/Profession")
public class ProfessionController {

    @Autowired
    ProfessionServiceImpl professionService;

    //尚未增加权限监测
    @PostMapping
    @ApiImplicitParam(name = "profession",value = "新建专业结构体",dataTypeClass = ProfessionIn.class, paramType = "body")
    @ApiOperation(value = "用户新建窗口",notes = "会对专业进行唯一性验证，token验证暂未实现")
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
