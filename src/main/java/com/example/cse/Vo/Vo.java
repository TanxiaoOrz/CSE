package com.example.cse.Vo;

public class Vo<Value> {
    //正常返回
    public static int Success = 0;
    //没有权限
    public static int NoAuthority = -1;
    //错误的数据携带
    public static int WrongPostParameter = 1;

    int status;//对于返回

    Value data;

    public Vo(int status, Value data){
        this.status = status;
        this.data = data;
    }

    public int getStatus() {
        return status;
    }

    public Value getData() {
        return data;
    }
}
