package com.example.cse.Utils.Exception;

public class NoDataException extends Exception{

    private int status;
    private String description;

    public NoDataException(int status, String description) {
        super();
        this.status = status;
        this.description= description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
