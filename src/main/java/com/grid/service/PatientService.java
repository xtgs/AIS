package com.grid.service;

import com.grid.entity.*;

/**
 * Created by wanghuijian on 17/11/16.
 */
public interface PatientService {
    String getPatientByParam(QueryPatientParamBean queryPatientParamBean, String page, String rows, String sort, String order);

    PatientBean getPatientById(String pid);

    String saveAddPatient(PatientBean patientBean);

    String saveModifyPatient(PatientBean patientBean);

    String deletePatientById(String pid);

    String chargeInBalance(ChargeBean chargeBean);
    String topupInBalance(TopupBean topupBean);

    TradeRecordBean getTradeRecordById(String tradeId);

    String getTradeRecordByParam(QueryTradeRecordBean queryTradeRecordBean, String page, String rows, String sort, String order);
}
