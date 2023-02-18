package com.example.cse.Vo;

import com.example.cse.Dto.HobbyDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "HobbyIn",description = "创建喜好时的结构体")
public class HobbyIn extends HobbyOut{

    @ApiModelProperty
    private ModelVo model;

    public HobbyIn() {
        super();
    }

    public ModelVo getModel() {
        return model;
    }

    public void setModel(ModelVo model) {
        this.model = model;
    }
}
