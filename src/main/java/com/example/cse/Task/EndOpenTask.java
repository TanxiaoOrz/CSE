package com.example.cse.Task;

import com.example.cse.Config.WebMvcConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class EndOpenTask {

    private boolean sleepEnabled = true;

    @Autowired
    WebMvcConfig webMvcConfig;

    @Scheduled(cron = "0 0 4 * * ?")
    public void Open() {
        webMvcConfig.setOpen(true);
    }

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
