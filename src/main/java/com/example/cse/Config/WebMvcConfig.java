package com.example.cse.Config;

import com.auth0.jwt.exceptions.AlgorithmMismatchException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.cse.Dto.UserDto;
import com.example.cse.Service.impl.TokenServiceImpl;
import com.example.cse.Service.impl.UserServiceImpl;
import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Utils.Exception.SleepException;
import com.example.cse.Vo.Vo;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@Configuration
public class WebMvcConfig extends WebMvcConfigurationSupport{


    public void setOpen(boolean open) {
        this.open = open;
    }

    private boolean open =true;

    @Autowired
    TokenServiceImpl tokenService;

    @Autowired
    UserServiceImpl userService;


    protected boolean checkToken(HttpServletRequest request, HttpServletResponse response,boolean tokenNullable,int checkType) throws NoDataException {
        if (!open){
            throw new SleepException();
        }
        if (request.getMethod().equals("OPTIONS"))
            return true;
        String token = request.getHeader("token");

        if (!StringUtils.hasText(token) && tokenNullable) //对于部分不强制登录的界面的返回方式
            return true;

        String description = "错误的权限请求!!!";
        try {
            DecodedJWT decodedJWT = tokenService.verifyToken(token);
            switch (checkType) {
                case TokenServiceImpl.UserType:
                    if (tokenService.checkTokenType(decodedJWT, TokenServiceImpl.UserType)) {
                        UserDto userDto = tokenService.getUserByToken(decodedJWT);
                        if (userDto == null) {
                            userDto = userService.getUserByUid(decodedJWT.getClaim("Uid").asString());
                        }
                        request.setAttribute("UserDto", userDto);
                        return true;
                    }
                    break;
                case TokenServiceImpl.ManagerType:
                    if (tokenService.checkTokenType(decodedJWT,TokenServiceImpl.ManagerType))
                        return true;
            }
        }catch (TokenExpiredException e) {
            description = "Token已经过期!!!";
            throw new NoDataException(Vo.OutToken,description);
        } catch (SignatureVerificationException e) {
            description = "签名错误!!!";
        } catch (AlgorithmMismatchException e){
            description = "加密算法不匹配!!!";
        } catch (Exception e) {
            description = "无效token~~";
        }
        throw new NoDataException(Vo.NoAuthority,description);
    }

    class UserGet implements HandlerInterceptor {
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            return checkToken(request, response, true,TokenServiceImpl.UserType);
        }

        @Override
        public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
            HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
        }

        @Override
        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
            HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
        }
    }

    class UserCheck implements HandlerInterceptor {
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            if (request.getMethod().equals("POST")){
                return true;
            }else {
                return checkToken(request, response, false,TokenServiceImpl.UserType);
            }
        }

        @Override
        public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
            HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
        }

        @Override
        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
            HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
        }
    }

    class ManagerCheck implements HandlerInterceptor {
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            if (request.getMethod().equals("POST")){
                return true;
            }else {
                return checkToken(request, response, false,TokenServiceImpl.ManagerType);
            }
        }

        @Override
        public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
            HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
        }

        @Override
        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
            HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
        }
    }


    class TokenCheck implements HandlerInterceptor {

        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            return checkToken(request,response,false,TokenServiceImpl.UserType);
        }

        @Override
        public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
            HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
        }

        @Override
        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
            HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
        }
    }


    @Override
    protected void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(new TokenCheck())
                .addPathPatterns("/cse/User/**")
                .addPathPatterns("/cse/Hobby/User")
                .excludePathPatterns("/cse/User")
                .excludePathPatterns("/cse/Token/**")//不需要拦截的地
                .excludePathPatterns("/favicon.ico")
                .excludePathPatterns("file")
                .excludePathPatterns("/swagger-ui.html/**",
                       "/swagger-ui/**",
                       "/swagger-resources/**",
                       "/v2/api-docs",
                       "/v3/api-docs",
                       "/v3/api-docs/swagger-config",
                       "/webjars/**",
                       "/doc.html");
        registry.addInterceptor(new UserCheck())
               .addPathPatterns("/cse/User")
               .excludePathPatterns("/favicon.ico")
               .excludePathPatterns("/swagger-ui.html/**",
                       "/swagger-ui/**",
                       "/swagger-resources/**",
                       "/v2/api-docs",
                       "/v3/api-docs",
                       "/v3/api-docs/swagger-config",
                       "/webjars/**",
                       "/doc.html");
        registry.addInterceptor(new UserGet())
               .addPathPatterns("/cse/Location/User")
               .addPathPatterns("/cse/Location/User/**")
               .addPathPatterns("/cse/InformationClass/User/**")
               .addPathPatterns("/cse/InformationClass/User")
               .addPathPatterns("/cse/Message/User/**")
               .excludePathPatterns("/favicon.ico")
               .excludePathPatterns("/swagger-ui.html/**",
                       "/swagger-ui/**",
                       "/swagger-resources/**",
                       "/v2/api-docs",
                       "/v3/api-docs",
                       "/v3/api-docs/swagger-config",
                       "/webjars/**",
                       "/doc.html");
        registry.addInterceptor(new ManagerCheck())
                .addPathPatterns("/cse/Location/Manager")
                .addPathPatterns("/cse/Location/Manager/**")
                .addPathPatterns("/cse/InformationClass/Manager/**")
                .addPathPatterns("/cse/InformationClass/Manager")
                .addPathPatterns("/cse/Message/Manager/**")
                .addPathPatterns("/cse/Message/Manager")
                .addPathPatterns("/cse/Hobby/Manager")
                .addPathPatterns("/cse/Profession/Manager")
                .addPathPatterns("/cse/Key/Manager")
                .addPathPatterns("/cse/File/upload")
                .addPathPatterns("/cse/Manager/**")
                .excludePathPatterns("/favicon.ico")
                .excludePathPatterns("/swagger-ui.html/**",
                       "/swagger-ui/**",
                       "/swagger-resources/**",
                       "/v2/api-docs",
                       "/v3/api-docs",
                       "/v3/api-docs/swagger-config",
                       "/webjars/**",
                       "/doc.html");
        super.addInterceptors(registry);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("swagger-ui.html", "doc.html")
                .addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/");
        registry.addResourceHandler("/swagger-ui/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/springfox-swagger-ui/");
        registry.addResourceHandler("/**").addResourceLocations("classpath:/static/");


        //appConfig.getResPhysicalPath() 这表示项目所在的文件夹，下面会有介绍

        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/","file:static/");

        super.addResourceHandlers(registry);
    }


    //定义时间格式转换器
    @Bean
    public MappingJackson2HttpMessageConverter jackson2HttpMessageConverter() {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        converter.setObjectMapper(mapper);
        return converter;
    }

    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        //将我们定义的时间格式转换器添加到转换器列表中,
        //这样jackson格式化时候但凡遇到Date类型就会转换成我们定义的格式
        converters.add(jackson2HttpMessageConverter());
    }
}
