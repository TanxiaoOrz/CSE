package com.example.cse.Dto;

import com.example.cse.Entity.Recommend.Hobby;
import com.example.cse.Utils.Model;
import com.example.cse.Vo.HobbyOut;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

public class HobbyDto {

    private Integer Hid;
    private String name;
    private String description;
    private String type;
    private Model model;

    public HobbyDto(Hobby hobby){
        Hid = hobby.getHid();
        name = hobby.getName();
        description = hobby.getDescription();
        type = hobby.getType();
        model = new Gson().fromJson(hobby.getModel(),Model.class);
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

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }
}
