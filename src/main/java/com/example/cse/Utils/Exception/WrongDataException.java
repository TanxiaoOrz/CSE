package com.example.cse.Utils.Exception;

import com.example.cse.Vo.Vo;

public class WrongDataException extends NoDataException{
    public WrongDataException(String description) {
        super(description);
        setStatus(Vo.WrongDataGet);
    }
}
