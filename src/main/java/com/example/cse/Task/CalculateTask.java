package com.example.cse.Task;

import com.example.cse.Service.impl.ModelServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@EnableScheduling
@EnableAsync
@Component
public class CalculateTask {

    private boolean calculateEnabled = false;

    private int calculateDegree = MODIFY_HOBBY;

    Logger logger = LoggerFactory.getLogger(getClass());

    public final static int REGENERATE_ALL = 0;
    public final static int REGENERATE_HOBBY = 1;
    public final static int MODIFY_ALL = 2;
    public final static int MODIFY_BASIC = 3;
    public final static int MODIFY_HOBBY = 4;
    @Autowired
    ModelServiceImpl modelService;

    @Scheduled(cron = "0 1 3 * * ?")
    public void calculateModel() {
        if (!calculateEnabled) {
            logger.info("计算选项未启用");
            return;
        }
        switch (calculateDegree) {
            case REGENERATE_ALL:
                modelService.regenerateHobbyModel();
                modelService.calculateBasicModelScore();
                break;
            case REGENERATE_HOBBY:
                modelService.regenerateHobbyModel();
                break;
            case MODIFY_HOBBY:
                modelService.calculateHobbyModel();
                break;
            case MODIFY_ALL:
                modelService.calculateHobbyModel();
                modelService.calculateBasicModelScore();
                break;
            case MODIFY_BASIC:
                modelService.calculateBasicModelScore();
                break;

        }
    }



    public boolean isCalculateEnabled() {
        return calculateEnabled;
    }

    public void setCalculateEnabled(boolean calculateEnabled) {
        this.calculateEnabled = calculateEnabled;
    }

    public int getCalculateDegree() {
        return calculateDegree;
    }

    public void setCalculateDegree(int calculateDegree) {
        this.calculateDegree = calculateDegree;
    }
}
