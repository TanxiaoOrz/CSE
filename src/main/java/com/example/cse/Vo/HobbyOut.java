package com.example.cse.Vo;

import com.example.cse.Dto.HobbyDto;
import com.example.cse.Entity.Recommend.Hobby;
import com.example.cse.Mapper.HobbyMapper;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.ArrayList;
import java.util.List;

@ApiModel(value = "HobbyOut",description = "喜好输出结构体")
public class HobbyOut {

    @ApiModelProperty("爱好编号")
    private Integer Hid;
    @ApiModelProperty("爱好名")
    protected String Name;
    @ApiModelProperty("爱好描述")
    protected String Description;
    @ApiModelProperty("爱好类型")
    protected String Type;

    public HobbyOut() {
    }

    public HobbyOut(HobbyDto hobby){
        Hid = hobby.getHid();
        Name = hobby.getName();
        Description = hobby.getDescription();
        Type = hobby.getType();
    }

    public static List<HobbyOut> createHobbyOuts(List<HobbyDto> hobbyDtos){
        List<HobbyOut> hobbyOuts = new ArrayList<>();
        for (HobbyDto hobby: hobbyDtos) {
            hobbyOuts.add(new HobbyOut(hobby));
        }
        return hobbyOuts;
    }

    public Integer getHid() {
        return Hid;
    }

    public void setHid(Integer hid) {
        Hid = hid;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        Type = type;
    }
}
