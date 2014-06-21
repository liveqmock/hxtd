package com.baihui.test.json;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;

import java.util.Date;

//    @JsonFilter("bean")
public class Bean {

    static class Public {
    }

    static class ExtendedPublic extends Public {
    }

    static class Internal extends ExtendedPublic {
    }

    // Name is public

    @JsonView(Public.class)
    String name;
    @JsonView(ExtendedPublic.class)
    String address;
    @JsonView(Internal.class)
    String ssn;

    @JsonView(Internal.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    Date date;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}