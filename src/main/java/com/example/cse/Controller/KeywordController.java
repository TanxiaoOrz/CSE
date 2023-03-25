package com.example.cse.Controller;

import com.example.cse.Entity.Recommend.KeyWord;
import com.example.cse.Entity.Recommend.KeyWordType;
import com.example.cse.Entity.Recommend.TypeWithKey;
import com.example.cse.Service.impl.KeyServiceImpl;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("cse/Key")
@Api(tags = "关键词接口")
@CrossOrigin
public class KeywordController {

    @Autowired
    KeyServiceImpl keyService;

    @PostMapping("/Manager/Keyword")
    @ApiOperation(value = "管理员新建关键词",notes = "传入关键词结构体，需要进行管理员验证")
    @ApiImplicitParam(name = "keyWord",value = "要新建的关键词结构体",dataTypeClass = KeyWord.class,paramType = "body")
    public Vo<String> newKey(@RequestBody KeyWord keyWord) {
        if (keyService.newKey(keyWord) != 0)
            return new Vo<>("新建成功");
        else
            return new Vo<>("位置错误");
    }

    @PostMapping("/Manager/KeyType")
    @ApiOperation(value = "管理员新建关键词类型",notes = "传入关键词类型结构体，需要进行管理员验证")
    @ApiImplicitParam(name = "keyWordType",value = "要新建的关键词类型结构体",dataTypeClass = KeyWordType.class,paramType = "body")
    public Vo<String> newType(@RequestBody KeyWordType keyWordType) {
        if (keyService.newType(keyWordType) != 0)
            return new Vo<>("新建成功");
        else
            return new Vo<>("位置错误");
    }

    @GetMapping
    @ApiOperation(value = "获取所有关键词",notes = "按类型分级")
    public Vo<List<TypeWithKey>> getAllTypeWithKeys() {
        return new Vo<>(keyService.getAll());
    }



}
