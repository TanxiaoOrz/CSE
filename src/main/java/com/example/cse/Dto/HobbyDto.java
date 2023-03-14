package com.example.cse.Dto;

import com.example.cse.Entity.Recommend.Hobby;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.ArrayList;
import java.util.List;

@ApiModel(description = "爱好包装类")
public class HobbyDto {

    @ApiModelProperty("唯一id")
    private Integer Hid;
    @ApiModelProperty("爱好名")
    private String name;
    @ApiModelProperty("描述")
    private String description;
    @ApiModelProperty("类型")
    private String type;
    @ApiModelProperty("附属的推荐模型")
    private List<ModelDto> modelDtos;

    public HobbyDto(Hobby hobby){
        Hid = hobby.getHid();
        name = hobby.getName();
        description = hobby.getDescription();
        type = hobby.getType();
        if (hobby.getModel() != null) {
            JsonArray array = new JsonParser().parse(hobby.getModel()).getAsJsonArray();
            Gson gson = new Gson();
            modelDtos = new ArrayList<>();
            for (JsonElement element:array){
                ModelDto modelDto = gson.fromJson(element,ModelDto.class);
                modelDtos.add(modelDto);
            }
        }
    }

    public static List<HobbyDto> createHobbyDtoList(List<Hobby> hobbies){
        List<HobbyDto> hobbyOuts = new ArrayList<>();
        for (Hobby hobby: hobbies) {
            hobbyOuts.add(new HobbyDto(hobby));
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

    public List<ModelDto> getModel() {
        return modelDtos;
    }

    public void setModel(List<ModelDto> modelDto) {
        this.modelDtos = modelDto;
    }
}
