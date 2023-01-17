package com.example.cse.bean.InformationClass;

import com.example.cse.bean.Recommend.Model;

import java.util.ArrayList;
import java.util.HashMap;

public abstract class InformationClass {


    public final static Integer LOCATION = 0;
    public final static Integer RESOURCE = 1;
    public final static Integer LESSON = 2;
    public final static Integer SECTION = 3;
    public final static Integer CONTEST = 4;
    public final static Integer ACTIVITY = 5;
    public final static Class<?>[] Type ={Location.class,Resource.class,Lesson.class,Section.class,Contest.class,Activity.class};

    Message BasicMessage;//在类页面一定显示的描述性信息
    String Resume;//简介
    String Name;//名字

    Model recommend;//惊醒推荐操作的匹配模型
    ArrayList<Message> messages;//该类的从属信息

    HashMap<String,String> toJsonMap;//选择产生传递Json信息的部分

    Integer classType;

}
