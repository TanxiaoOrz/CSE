package com.example.cse.Task;

import com.example.cse.Config.WebMvcConfig;
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

    @Async
    @Scheduled(cron = "0 0 4 * * ?")
    public void Open() {
        webMvcConfig.setOpen(true);
    }

    @Async
    @Scheduled(cron = "0 0 3 * * ?")
    public void Shutdown() {
        webMvcConfig.setOpen(false);
    }

    public boolean isSleepEnabled() {
        return sleepEnabled;
    }

    public void setSleepEnabled(boolean sleepEnabled) {
        this.sleepEnabled = sleepEnabled;
    }
}
