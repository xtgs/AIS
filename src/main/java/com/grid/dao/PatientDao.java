package com.grid.dao;

import com.grid.entity.*;

import java.util.List;

/**
 * Created by wanghuijian on 17/11/15.
 */
public interface PatientDao {

    List<PatientBean> getPatientByParam(QueryPatientParamBean queryPatientParamBean);

    int getPatientByParamCount(QueryPatientParamBean queryPatientParamBean);

    PatientBean getPatientById(String pid);
    int deletePatientById(String pid);

    int insert(PatientBean patientBean);
    int update(PatientBean patientBean);

    int charge(ChargeBean chargeBean);
    int topup(TopupBean topupBean);

    List<TradeRecordBean> getTradeRecordByParam(QueryTradeRecordBean queryTradeRecordBean);
    int getTradeRecordCountByParam(QueryTradeRecordBean queryTradeRecordBean);


}
