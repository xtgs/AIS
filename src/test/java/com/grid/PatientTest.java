package com.grid;

import com.grid.dao.PatientDao;
import com.grid.entity.PatientBean;
import com.grid.entity.QueryPatientParamBean;
import com.grid.entity.QueryTradeRecordBean;
import com.grid.entity.TradeRecordBean;
import org.junit.Test;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/11/16.
 */
public class PatientTest extends BaseTest{
    @Resource
    private PatientDao patientDao;

    @Test
    public void getPatientByParamCount() {
        QueryPatientParamBean queryPatientParamBean = new QueryPatientParamBean();
        queryPatientParamBean.setStartnum(0);
        queryPatientParamBean.setGetrows(10);
        System.out.println(patientDao.getPatientByParamCount(queryPatientParamBean));
        List<PatientBean> patientBeanList = patientDao.getPatientByParam(queryPatientParamBean);
        for (PatientBean patientBean : patientBeanList) {
            System.out.println(patientBean);
        }
    }

    @Test
    public void getTradeRecordByParamTest() {
        QueryTradeRecordBean queryTradeRecordBean = new QueryTradeRecordBean();
        List<TradeRecordBean> tradeRecordBeanList = patientDao.getTradeRecordByParam(queryTradeRecordBean);
        System.out.println(patientDao.getTradeRecordCountByParam(queryTradeRecordBean));
        for (TradeRecordBean tradeRecordBean : tradeRecordBeanList) {
            System.out.println(tradeRecordBean);
        }
    }
}
