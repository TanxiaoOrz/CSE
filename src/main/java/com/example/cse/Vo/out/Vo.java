package com.example.cse.Vo.out;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "Vo", description = "对返回的信息进行结果包装或错误描述")
public class Vo<Value> {
    //正常返回
    public static int Success = 0;
    //没有权限
    public static int NoAuthority = -1;
    //错误的数据携带
    public static int WrongPostParameter = 1;

    @ApiModelProperty(value = "返回成功与否描述")
    int status;//对于返回
    @ApiModelProperty(value = "返回的具体数据")
    Value data;
    @ApiModelProperty(value = "信息描述")
    String description;


    public Vo(int status, Value data,String description){
        this.status = status;
        this.data = data;
        this.description=null;
    }


    public int getStatus() {
        return status;
    }


    public Value getData() {
        return data;
    }

    public String getDescription() {
        return description;
    }
}
