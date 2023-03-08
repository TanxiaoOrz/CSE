package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.KeyWord;
import org.springframework.util.StringUtils;

public class Location {
    private Integer lid;//唯一标识
    private String name;
    private String resume;
    private String ability;
    private Integer basicMessage;
    private Integer mapBelong;
    private Integer mapOwn;
    private String imgHref;//所携带的图片
    private Integer x;//所在地图坐标
    private Integer y;

    public void checkZeroToNull() {
        if (mapOwn !=null && mapOwn == 0) {
            mapOwn =null;
        }
        if (mapBelong !=null && mapBelong == 0) {
            mapBelong =null;
        }
        if (basicMessage !=null && basicMessage == 0) {
            basicMessage = null;
        }
        if (!StringUtils.hasText(imgHref)) {
            imgHref = null;
        }
        if (!StringUtils.hasText(ability)) {
            ability = null;
        }
    }

    public boolean checkUpdate(Location old) {
        boolean update = true;
        if (name != null) {
            update = name.equals(old.name);
        }
        if (resume != null) {
            update &= resume.equals(old.resume);
        }
        if (ability != null) {
            update &= ability.equals(old.ability);
        }
        if (basicMessage != null) {
            update &= basicMessage.equals(old.basicMessage);
        }
        if (mapBelong != null) {
            update &= mapBelong.equals(old.mapBelong);
        }
        if (mapOwn != null) {
            update &= mapOwn.equals(old.mapOwn);
        }
        if (x != null) {
            update &= x.equals(old.x);
        }
        if (y != null) {
            update &= y.equals(old.y);
        }
        if (imgHref != null) {
            update &= imgHref.equals(old.imgHref);
        }
        return  update;
    }

    public Integer getLid() {
        return lid;
    }

    public void setLid(Integer lid) {
        this.lid = lid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public String getAbility() {
        return ability;
    }

    public void setAbility(String ability) {
        this.ability = ability;
    }

    public Integer getBasicMessage() {
        return basicMessage;
    }

    public void setBasicMessage(Integer basicMessage) {
        this.basicMessage = basicMessage;
    }

    public Integer getMapBelong() {
        return mapBelong;
    }

    public void setMapBelong(Integer mapBelong) {
        this.mapBelong = mapBelong;
    }

    public Integer getMapOwn() {
        return mapOwn;
    }

    public void setMapOwn(Integer mapOwn) {
        this.mapOwn = mapOwn;
    }

    public String getImgHref() {
        return imgHref;
    }

    public void setImgHref(String imgHref) {
        this.imgHref = imgHref;
    }

    public Integer getX() {
        return x;
    }

    public void setX(Integer x) {
        this.x = x;
    }

    public Integer getY() {
        return y;
    }

    public void setY(Integer y) {
        this.y = y;
    }
}
