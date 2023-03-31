package com.example.cse.Vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description = "标准包装类对返回的信息进行结果包装或错误描述")
public class Vo<Value> {
    //正常返回
    public static int Success = 0;
    //没有权限
    public static int NoAuthority = -1;
    //错误的数据携带
    public static int WrongPostParameter = 1;
    //错误的数据存储
    public static int WrongDataGet = 2;

    public static int ServeSleep = 3;

    @ApiModelProperty(value = "返回成功与否描述,0成功，-1权限错误，1错误的参数，2得到了不符合标准的数据，请联系管理员")
    int status;//对于返回
    @ApiModelProperty(value = "返回的具体数据")
    Value data;
    @ApiModelProperty(value = "信息描述")
    String description;

    public Vo(Value data) {
        this(Vo.Success,data,null);
    }

    public Vo(int status,String description){
        this.status = status;
        this.data = null;
        this.description=description;
    }

    public Vo(int status, Value data, String description){
        this.status = status;
        this.data = data;
        this.description=description;
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
