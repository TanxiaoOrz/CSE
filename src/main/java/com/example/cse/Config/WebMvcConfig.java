package com.example.cse.Config;

import com.auth0.jwt.exceptions.AlgorithmMismatchException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.cse.Dto.UserDto;
import com.example.cse.Service.impl.TokenServiceImpl;
import com.example.cse.Vo.Vo;
import com.google.gson.Gson;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration
public class WebMvcConfig extends WebMvcConfigurationSupport{


    TokenServiceImpl tokenService;

    protected boolean checkToken(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String token = request.getHeader("token");
        String description;
        try {
            DecodedJWT decodedJWT = tokenService.verifyToken(token);
            if (tokenService.checkTokenType(decodedJWT, TokenServiceImpl.UserType)){
                UserDto userDto= tokenService.getUserByToken(decodedJWT);
                request.setAttribute("UserDto",userDto);
                return true;
            }else{
                description = "错误的权限请求!!!";
            }
        }catch (TokenExpiredException e) {
            description = "Token已经过期!!!";
        } catch (SignatureVerificationException e) {
            description = "签名错误!!!";
        } catch (AlgorithmMismatchException e){
            description = "加密算法不匹配!!!";
        } catch (Exception e) {
            e.printStackTrace();
            description = "无效token~~";
        }
        Vo<String> vo = new Vo<>(Vo.NoAuthority,null,description);

        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println(new Gson().toJson(vo));

        return false;
    }

    class UserCheck implements HandlerInterceptor {
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            if (request.getMethod().equals("POST")){
                return true;
            }else {
                return checkToken(request,response);
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
            return checkToken(request,response);
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
               .excludePathPatterns("/cse/User")
               .excludePathPatterns("/cse/Token/**")//不需要拦截的地
               .excludePathPatterns("/favicon.ico")
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
        super.addResourceHandlers(registry);
    }


}
