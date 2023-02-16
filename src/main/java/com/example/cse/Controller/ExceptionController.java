package com.example.cse.Controller;

import com.example.cse.Utils.Exception.NoDataException;
import com.example.cse.Vo.out.Vo;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@Api(tags = "异常处理控制器")
public class ExceptionController {

    @ExceptionHandler(NoDataException.class)
    public Vo<String> handleNoDataException(NoDataException e){
        return  new Vo<>(e.getStatus(), null,e.getDescription());
    }

    @ExceptionHandler(Exception.class)
    public Vo<Exception> handleException(Exception e){
        e.printStackTrace();
        return new Vo<>(Vo.WrongPostParameter,e,e.getMessage());
    }
}
