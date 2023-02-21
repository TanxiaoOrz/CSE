package com.example.cse.Entity.UserClass;

import com.example.cse.Entity.InformationClass.*;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.CalenderIn;
import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Calender {
    private Integer Uid;
    private Date Time;
    private String Description;
    String RelationFunction;

    public Calender() {

    }

    public Calender(CalenderIn calenderIn,Integer Uid, boolean hasDescription) throws NoDataException{
        this.Uid = Uid;
        if (StringUtils.hasText(calenderIn.getDescription()))
            this.Description =calenderIn.getDescription();
        else if (hasDescription)
            throw new NoDataException("没有描述");
        if (calenderIn.getTime()!=null) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                this.Time = format.parse(calenderIn.getTime());
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }
        else
            throw new NoDataException("没有描述");
    }

    public Integer getUid() {
        return Uid;
    }

    public void setUid(Integer uid) {
        Uid = uid;
    }

    public Date getTime() {
        return Time;
    }

    public void setTime(Date time) {
        Time = time;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public String getRelationFunction() {
        return RelationFunction;
    }

    public void setRelationFunction(String relationFunction) {
        RelationFunction = relationFunction;
    }
}
