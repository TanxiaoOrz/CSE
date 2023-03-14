package com.example.cse.Vo;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Entity.Recommend.Hobby;
import com.example.cse.Mapper.HobbyMapper;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.ArrayList;
import java.util.List;

@ApiModel(value = "喜好输出结构体")
public class HobbyOut {

    @ApiModelProperty("爱好编号")
    private Integer hid;
    @ApiModelProperty("爱好名")
    protected String name;
    @ApiModelProperty("爱好描述")
    protected String description;
    @ApiModelProperty("爱好类型")
    protected String type;

    public HobbyOut() {
    }

    public HobbyOut(HobbyDto hobby){
        hid = hobby.getHid();
        name = hobby.getName();
        description = hobby.getDescription();
        type = hobby.getType();
    }

    public static List<HobbyOut> createHobbyOuts(List<HobbyDto> hobbyDtos){
        List<HobbyOut> hobbyOuts = new ArrayList<>();
        for (HobbyDto hobby: hobbyDtos) {
            hobbyOuts.add(new HobbyOut(hobby));
        }
        return hobbyOuts;
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
