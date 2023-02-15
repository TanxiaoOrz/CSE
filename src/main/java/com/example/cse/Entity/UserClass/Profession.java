package com.example.cse.Entity.UserClass;


public class Profession{
    protected String professionName;
    protected String professionDescription;
    protected Integer Pid;

    public String getProfessionName() {
        return professionName;
    }

    public void setProfessionName(String professionName) {
        this.professionName = professionName;
    }

    public String getProfessionDescription() {
        return professionDescription;
    }

    public void setProfessionDescription(String professionDescription) {
        this.professionDescription = professionDescription;
    }

    public Integer getPid() {
        return Pid;
    }

    public void setPid(Integer pid) {
        Pid = pid;
    }
}
