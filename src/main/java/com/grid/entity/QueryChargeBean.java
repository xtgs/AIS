package com.grid.entity;

/**
 * Created by wanghuijian on 17/12/15.
 */
public class QueryChargeBean {
    private String patientName;
    private String doctorName;
    private String chargeTimeBegin;
    private String chargeTimeEnd;


    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getChargeTimeBegin() {
        return chargeTimeBegin;
    }

    public void setChargeTimeBegin(String chargeTimeBegin) {
        this.chargeTimeBegin = chargeTimeBegin;
    }

    public String getChargeTimeEnd() {
        return chargeTimeEnd;
    }

    public void setChargeTimeEnd(String chargeTimeEnd) {
        this.chargeTimeEnd = chargeTimeEnd;
    }
}
