package com.example.cse.Config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

@Configuration
public class SwaggerConfig {
    @Value("${config.controller-path}")
    private String controllerPath;
    @Value("${config.version}")
    private String version;
    @Value("${config.swagger-enable}")
    private boolean enable;

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public void setControllerPath(String controllerPath) {
        this.controllerPath = controllerPath;
    }

    @Bean
    public Docket createRestApi(){
        System.out.println(controllerPath);
        Docket docket = new Docket(DocumentationType.OAS_30);
        docket.apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage(controllerPath))
                .paths(PathSelectors.any());
        return docket.enable(enable);
    }

    private ApiInfo apiInfo(){
        return new ApiInfoBuilder()
                //设置标题
                .title("迅达服务器后端接口文档")
                //描述
                .description("迅达服务器前后端对接文档，包含Mapper层数据库实体与Controller接口")
                //作者信息
                .contact(new Contact("张骏山","https://github.com/TanxiaoOrz","13671985248@136.com"))
                //版本
                .version(version)
                //协议
                .license("Rhe Apache License")
                //协议url
                .licenseUrl("null")
                .build();
    }
}
