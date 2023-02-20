package com.example.cse.Utils;

public class TypeString {
    private Integer id;
    private String type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean checkData() {
        return type.equals("informationClass")||type.equals("location")||type.equals("message");
    }
}
