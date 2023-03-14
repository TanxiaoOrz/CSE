package com.example.cse.Vo;

import com.example.cse.Utils.Exception.NoDataException;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

@ApiModel(description = "专业的传入结构体")
public class ProfessionIn {
    @ApiModelProperty(value = "专业名",required = true)
    protected String professionName;
    @ApiModelProperty(value = "专业描述",required = true)
    protected String professionDescription;

    public void checkNull() throws NoDataException {
        if (!StringUtils.hasText(professionName)){
            throw new NoDataException(Vo.WrongPostParameter,"缺少专业名称");
        }
    }

    public String getProfessionDescription() {
        return professionDescription;
    }

    public void setProfessionDescription(String professionDescription) {
        this.professionDescription = professionDescription;
    }

    public String getProfessionName() {
        return professionName;
    }

    public void setProfessionName (String professionName) {
        this.professionName = professionName;
    }
}
