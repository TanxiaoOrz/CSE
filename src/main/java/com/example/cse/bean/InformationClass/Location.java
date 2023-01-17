package com.example.cse.bean.InformationClass;

import com.example.cse.bean.Recommend.KeyWord;

public class Location extends InformationClass{
    private Integer Lid;//唯一标识

    private Integer Ability;//对应对象链接的唯一标识
    private Integer Map;
    private String imgHref;//所携带的图片
    private Integer X;//所在地图坐标
    private Integer Y;

    private Map map;//从属地图
    private KeyWord ability;//提供的能力关键字
}
