package com.example.cse.Vo;

import com.example.cse.Dto.ModelDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(value = "创建喜好时的结构体")
public class HobbyIn extends HobbyOut{

    @ApiModelProperty("附带的推荐模型")
    private List<ModelDto> model;

    public HobbyIn() {
        super();
    }

    public List<ModelDto> getModel() {
        return model;
    }

    public void setModel(List<ModelDto> model) {
        this.model = model;
    }
}
