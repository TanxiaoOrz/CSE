package com.example.cse.Vo.in;

import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.out.Vo;
import org.springframework.util.StringUtils;

public class ProfessionIn {
    protected String professionName;
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
