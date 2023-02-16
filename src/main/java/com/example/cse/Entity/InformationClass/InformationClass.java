package com.example.cse.Entity.InformationClass;

import com.example.cse.Entity.Recommend.InfCal;
import com.example.cse.Utils.Model;

import java.util.ArrayList;
import java.util.HashMap;

public abstract class InformationClass implements InfCal {

    public final static Integer LOCATION = 0;
    public final static Integer RESOURCE = 1;
    public final static Integer SECTION = 2;
    public final static Integer CONTEST = 3;
    public final static Integer ACTIVITY = 4;
    public final static Class<?>[] Type ={Location.class,Resource.class,Section.class,Contest.class,Activity.class};

    Message BasicMessage;//在类页面一定显示的描述性信息
    String Resume;//简介
    String Name;//名字

    Model recommend;//惊醒推荐操作的匹配模型
    ArrayList<Message> messages;//该类的从属信息

    HashMap<String,String> toJsonMap;//选择产生传递Json信息的部分

    Integer classType;

}
