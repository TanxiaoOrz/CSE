package com.example.cse.bean.InformationClass;

import com.example.cse.bean.Recommend.KeyWord;

public class Lesson extends InformationClass{
    private Integer Lid;//唯一标识

    private Integer Profession;//对应关键词的唯一标识
    private Integer Teacher;
    private Integer LessonScore;

    private KeyWord profession;//关键词
    private KeyWord teacher;
    private KeyWord lessonScore;

}
