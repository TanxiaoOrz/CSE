package com.example.cse.Controller;

import com.example.cse.Service.impl.ManagerServiceImpl;
import com.example.cse.Utils.Exception.WrongDataException;
import com.example.cse.Vo.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Api(tags = "管理员操作接口")
@RequestMapping("/cse/Manager")
@CrossOrigin
public class ManagerController {

    @Autowired
    ManagerServiceImpl managerService;

    @GetMapping("/config")
    @ApiOperation(value = "获取管理员设置", notes = "需要管理员token")
    public Vo<ManagerConfig> getConfig() {
        return new Vo<>(managerService.getConfig());
    }

    @PostMapping("/config")
    @ApiOperation(value = "获取管理员设置", notes = "需要管理员token")
    public Vo<String> updateConfig(@RequestBody ManagerConfig managerConfig) throws WrongDataException {
        String string;
        if (managerService.updateConfig(managerConfig))
            string = "更新完成";
        else
            string = "没有修改";
        return new Vo<>(string);
    }

    @GetMapping("/most")
    @ApiOperation(value = "获取访问最多的数据", notes = "需要经过token验证")
    public Vo<SurfMost> getMost() {
        return new Vo<>(managerService.getSurfMost());
    }

    @GetMapping("/informationClass")
    @ApiOperation(value = "获取信息类浏览数据变化趋势", notes = "需要经过token验证,返回的是最近7天的访问数据")
    public Vo<TimeSurfInformationClass> getTimeChangeSurfInformationClass() {
        return new Vo<>(managerService.getTimeChangeSurfInformationClass());
    }

    @GetMapping("/time")
    @ApiOperation(value = "浏览数据散点图接口", notes = "需要经过token验证,返回的是最近7天的访问次数的自然对数缩小化，非真是存储值，实际表达是请用级别表示")
    public Vo<List<List<Integer>>> getSurfTime() {
        return new Vo<>(managerService.getSurfTime());
    }
}
