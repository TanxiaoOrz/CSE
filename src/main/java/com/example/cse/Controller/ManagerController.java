package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.impl.ManagerServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.ManagerConfig;
import com.example.cse.Vo.SurfMost;
import com.example.cse.Vo.UserCreate;
import com.example.cse.Vo.Vo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@Api(tags = "管理员操作接口")
@RequestMapping("/cse/Manager")
public class ManagerController {

    @Autowired
    ManagerServiceImpl managerService;

    @GetMapping("/config")
    @ApiOperation(value = "获取管理员设置",notes ="需要管理员token")
    public Vo<ManagerConfig> getConfig() {
        return new Vo<>(managerService.getConfig());
    }

    @PostMapping("/config")
    @ApiOperation(value = "获取管理员设置",notes ="需要管理员token")
    public Vo<String> updateConfig(@RequestBody ManagerConfig managerConfig) throws WrongDataException {
        String string;
        if (managerService.updateConfig(managerConfig))
            string = "更新完成";
        else
            string = "没有修改";
        return new Vo<>(string);
    }

    @GetMapping("/most")
    @ApiOperation(value = "获取访问最多的数据",notes = "需要经过token验证")
    public Vo<SurfMost> getMost() {
        return new Vo<>(managerService.getSurfMost());
    }
}
