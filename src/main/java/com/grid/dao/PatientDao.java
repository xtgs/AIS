package com.grid.dao;

import com.grid.entity.PatientBean;
import com.grid.entity.QueryPatientParamBean;

import java.util.List;

/**
 * Created by wanghuijian on 17/11/15.
 */
public interface PatientDao {

    List<PatientBean> getPatientByParam(QueryPatientParamBean queryPatientParamBean);

    int getPatientByParamCount(QueryPatientParamBean queryPatientParamBean);
}
