package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.KeyWord;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

@ApiModel("地点的实体类")
public class Location {
    @ApiModelProperty("唯一id标识")
    private Integer lid;//唯一标识
    @ApiModelProperty("地点名")
    private String name;
    @ApiModelProperty("地点简介")
    private String resume;
    @ApiModelProperty("地点权能")
    private String ability;
    @ApiModelProperty("简介消息的id")
    private Integer basicMessage;
    @ApiModelProperty("所属地图的路径")
    private String mapBelong;
    @ApiModelProperty("图片的路径")
    private String imgHref;//所携带的图片
    @ApiModelProperty("横坐标的偏移量")
    private Integer x;//所在地图坐标
    @ApiModelProperty("纵坐标的偏移量")
    private Integer y;

    public void checkZeroToNull() {
        if (!StringUtils.hasText(mapBelong)) {
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

    public String getMapBelong() {
        return mapBelong;
    }

    public void setMapBelong(String mapBelong) {
        this.mapBelong = mapBelong;
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
