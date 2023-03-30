package com.example.cse.Dto;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.ArrayList;
import java.util.List;

@ApiModel(description = "推荐模型")
public class ModelDto {

    @ApiModelProperty("推荐对象的id")
    Integer id;
    @ApiModelProperty("推荐分值")
    Integer score;
    @ApiModelProperty(value = "该模型针对的对象类型",allowableValues = "keyword,informationClass,location")
    String type;

    public static List<ModelDto> getModelDtos(String model) {
        JsonArray array = new JsonParser().parse(model).getAsJsonArray();
        Gson gson = new Gson();
        List<ModelDto> modelDtos = new ArrayList<>();
        for (JsonElement element:array){
            ModelDto modelDto = gson.fromJson(element,ModelDto.class);
            modelDtos.add(modelDto);
        }
        return modelDtos;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
