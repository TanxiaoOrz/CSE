package com.example.cse.Task;

import com.example.cse.Mapper.DeleteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class DeleteTask {
    @Autowired
    DeleteMapper deleteMapper;

    @Scheduled(cron = "0 0 3 * * ?")
    public void deleteStorage() {
        deleteMapper.deleteMessage();
        deleteMapper.deleteOutMessage();
        deleteMapper.deleteInformationClass();
        deleteMapper.deleteLocation();
        deleteMapper.deleteCalender();
    }

    @Scheduled(cron = "0 15 1 * * ?")
    public void deleteSurf() {
        deleteMapper.deleteMessageSurfOut();
        deleteMapper.deleteLocationSurfOut();
        deleteMapper.deleteInformationClassSurfOut();
    }

}
