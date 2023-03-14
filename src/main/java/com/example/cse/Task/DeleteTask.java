package com.example.cse.Task;

import com.example.cse.Mapper.DeleteMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class DeleteTask {


    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    DeleteMapper deleteMapper;

    @Scheduled(cron = "0 0 3 * * ?")
    public void deleteStorage() {
        Integer deleteMessage = deleteMapper.deleteMessage();
        logger.info("删除消息数量："  + deleteMessage);
        Integer deleteOutMessage = deleteMapper.deleteOutMessage();
        logger.info("删除过时消息数量："  + deleteOutMessage);
        Integer deleteInformationClass = deleteMapper.deleteInformationClass();
        logger.info("删除信息类数量："  + deleteInformationClass);
        Integer deleteLocation = deleteMapper.deleteLocation();
        logger.info("删除地点类数量："  + deleteLocation);
        Integer deleteCalender = deleteMapper.deleteCalender();
        logger.info("删除代办事务数量："  + deleteCalender);
    }

    @Scheduled(cron = "0 15 1 * * ?")
    public void deleteSurf() {
        Integer deleteMessageSurfOut = deleteMapper.deleteMessageSurfOut();
        logger.info("删除过时消息浏览记录：" +deleteMessageSurfOut);
        Integer deleteLocationSurfOut = deleteMapper.deleteLocationSurfOut();
        logger.info("删除过时消息浏览记录：" +deleteLocationSurfOut);
        Integer deleteInformationClassSurfOut = deleteMapper.deleteInformationClassSurfOut();
        logger.info("删除过时消息浏览记录：" +deleteInformationClassSurfOut);
    }

}
