package com.example.cse.Utils.Exception;

import com.example.cse.Vo.Vo;

public class SleepException extends NoDataException{
    public SleepException() {
        super(Vo.ServeSleep,"服务器停止访问，正在进行自我优化，4:00将开放服务");
    }
}
