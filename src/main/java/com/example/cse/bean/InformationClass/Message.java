package com.example.cse.bean.InformationClass;

import com.example.cse.bean.Recommend.Model;

import java.util.ArrayList;
import java.util.Date;

public class Message {
    private Integer Mid;//唯一消息标识号
    private Visual Visual;//可视化方式
    private String Title;//消息标题
    private String Resume;//消息简介
    private String Message;//消息本体
    private Date ReleaseTime;//消息放出时间
    private Date OutTime;//消息过期时间

    private ArrayList<InformationClass> classLink; //该消息对类的从属关系
    private Model rankModel;//当排序时调用的模型
}
