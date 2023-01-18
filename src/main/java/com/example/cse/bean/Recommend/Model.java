package com.example.cse.bean.Recommend;

import com.example.cse.bean.InformationClass.InformationClass;
import com.example.cse.bean.UserClass.User;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class Model  {
    List<KeyWord> keyWords;//将用户的关键词匹配存储在此处
    User user;
    List<Hobby> userHobby;
    HashMap<String,ArrayList<InformationClass>> ClassRank;//存储信息实体类的等级排名

    HashMap<String,ArrayList<Date>> TimeRank;
    HashMap<String,ArrayList<Integer>> SurfRank;

}
