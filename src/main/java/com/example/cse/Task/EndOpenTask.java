package com.example.cse.Task;

import com.example.cse.Config.WebMvcConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
@EnableAsync
public class EndOpenTask {

    private boolean sleepEnabled = true;

    @Autowired
    WebMvcConfig webMvcConfig;

    Logger logger = LoggerFactory.getLogger(getClass());

    @Async
    @Scheduled(cron = "0 0 4 * * ?")
    public void Open() {
        webMvcConfig.setOpen(true);
        logger.info("后端服务器回复运行");
    }

    @Async
    @Scheduled(cron = "0 0 3 * * ?")
    public void Shutdown() {
        if (!sleepEnabled) {
            logger.info("休眠选项未启用");
            return;
        }
        webMvcConfig.setOpen(false);
        logger.info("后端服务器休眠自检");
    }

    public boolean isSleepEnabled() {
        return sleepEnabled;
    }

    public void setSleepEnabled(boolean sleepEnabled) {
        this.sleepEnabled = sleepEnabled;
    }
}
