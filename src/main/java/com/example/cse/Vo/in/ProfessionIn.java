package com.example.cse.Vo.in;

import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

@ApiModel(value = "ProfessionIn", description = "新建专业的结构体")
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
