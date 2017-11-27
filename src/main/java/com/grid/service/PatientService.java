package com.grid.service;

import com.grid.entity.QueryPatientParamBean;

/**
 * Created by wanghuijian on 17/11/16.
 */
public interface PatientService {
    String getPatientByParam(QueryPatientParamBean queryPatientParamBean, String page, String rows, String sort, String order);
}
