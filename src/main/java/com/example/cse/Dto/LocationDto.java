package com.example.cse.Dto;

import com.example.cse.Entity.InformationClass.Location;

public class LocationDto extends Location {

    public LocationDto() {

    }

    public LocationDto(Location location) {
        setLid(location.getLid());
        setAbility(location.getAbility());
        setImgHref(location.getImgHref());
        setMapBelong(location.getMapBelong());
        setName(location.getName());
        setResume(location.getResume());
        setMapOwn(location.getMapOwn());
    }
}
