package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.ChargeDao;
import com.grid.dao.PatientDao;
import com.grid.entity.ChargeBean;
import com.grid.entity.PatientBean;
import com.grid.entity.QueryChargeBean;
import com.grid.service.ChargeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/14.
 */
@Service
public class ChargeServiceImpl implements ChargeService {

    @Resource
    private ChargeDao chargeDao;

    @Resource
    private PatientDao patientDao;

    @Override
    public String addOneChargeRecord(ChargeBean chargeBean) {
        PatientBean patientBean = patientDao.getPatientById(chargeBean.getPid());
        chargeBean.setAfterBalance(patientBean.getBalance());
        int result = chargeDao.insert(chargeBean);
        if (result > 0) {
            return "消费记录添加成功";
        } else {
            return "消费记录添加失败";
        }
    }

    @Override
    public String queryChargeReord(QueryChargeBean queryChargeBean) {
        int chargeRecordCount = chargeDao.getChargeRecordCountByParam(queryChargeBean);
        List<ChargeBean> chargeRecordList = chargeDao.getChargeRecordByParam(queryChargeBean);


        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", chargeRecordCount);
        jsonObject.put("rows", chargeRecordList);
        return jsonObject.toString();
    }


}
