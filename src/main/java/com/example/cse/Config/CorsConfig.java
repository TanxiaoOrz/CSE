package com.example.cse.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry corsRegistry){
            corsRegistry.addMapping("/**")
                    .allowCredentials(false)
                    .allowedOrigins("*")
                    .allowedMethods("GET","POST","DELETE","PUT","PATCH")
                    .maxAge(3600);
    }
}



