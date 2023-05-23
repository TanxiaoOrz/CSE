package com.example.cse.Service.impl;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ModelServiceImplTest {
    @Autowired
    ModelServiceImpl modelService;

    @BeforeEach
    void setUp() {
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void calculateHobbyModel() {
        modelService.calculateHobbyModel();
    }

    @Test
    void regenerateHobbyModel() {
        modelService.regenerateHobbyModel();
    }

    @Test
    void calculateBasicModelScore() {
        modelService.calculateBasicModelScore();
    }
}