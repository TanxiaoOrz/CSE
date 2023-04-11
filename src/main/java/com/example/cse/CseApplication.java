package com.example.cse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class CseApplication {

    public static void main(String[] args) {
        SpringApplication.run(CseApplication.class, args);
    }

}
