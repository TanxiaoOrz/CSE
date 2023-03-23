package com.example.cse.Vo;

import com.example.cse.Entity.InformationClass.InformationClass;
import com.example.cse.Entity.InformationClass.Location;
import com.example.cse.Entity.InformationClass.Message;
import com.example.cse.Entity.Recommend.KeyAndType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(description = "返回用户浏览量最多的")
public class SurfMost {
    @ApiModelProperty("访问次数，按次数排序")
    List<Integer> informationClassCounts;
    @ApiModelProperty("访问次数，按次数排序")
    List<Integer> locationCounts;
    @ApiModelProperty("访问次数，按次数排序")
    List<Integer> keyCounts;
    @ApiModelProperty("排名前列的，按次数排序")
    List<InformationClass> informationClasses;
    @ApiModelProperty("排名前列的，按次数排序")
    List<Location> locations;
    @ApiModelProperty("排名前列的，按次数排序")
    List<KeyAndType> keyAndTypes;

    public SurfMost() {
    }

    public SurfMost(List<Integer> informationClassCounts, List<Integer> locationCounts, List<Integer> keyCounts, List<InformationClass> informationClasses, List<Location> locations, List<KeyAndType> keyAndTypes) {
        this.informationClassCounts = informationClassCounts;
        this.locationCounts = locationCounts;
        this.keyCounts = keyCounts;
        this.informationClasses = informationClasses;
        this.locations = locations;
        this.keyAndTypes = keyAndTypes;
    }

    public List<Integer> getLocationCounts() {
        return locationCounts;
    }

    public void setLocationCounts(List<Integer> locationCounts) {
        this.locationCounts = locationCounts;
    }

    public List<Integer> getKeyCounts() {
        return keyCounts;
    }

    public void setKeyCounts(List<Integer> keyCounts) {
        this.keyCounts = keyCounts;
    }

    public List<Integer> getInformationClassCounts() {
        return informationClassCounts;
    }

    public void setInformationClassCounts(List<Integer> informationClassCounts) {
        this.informationClassCounts = informationClassCounts;
    }

    public List<InformationClass> getInformationClasses() {
        return informationClasses;
    }

    public void setInformationClasses(List<InformationClass> informationClasses) {
        this.informationClasses = informationClasses;
    }

    public List<Location> getLocations() {
        return locations;
    }

    public void setLocations(List<Location> locations) {
        this.locations = locations;
    }

    public List<KeyAndType> getKeyAndTypes() {
        return keyAndTypes;
    }

    public void setKeyAndTypes(List<KeyAndType> keyAndTypes) {
        this.keyAndTypes = keyAndTypes;
    }
}
