package com.example.cse.Utils;

import com.example.cse.Dto.ModelDto;

import java.util.HashMap;

public class ModelUtils {

    public static void addModel(HashMap<Integer,Integer> models, Integer id, Integer score){
        if (models.containsKey(id)){
            models.replace(id, models.get(id)+score);
        }else {
            models.put(id,score);
        }
    }

}
