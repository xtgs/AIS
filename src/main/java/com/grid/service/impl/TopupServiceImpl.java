package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.PatientDao;
import com.grid.dao.TopupDao;
import com.grid.entity.PatientBean;
import com.grid.entity.QueryTopupBean;
import com.grid.entity.TopupBean;
import com.grid.service.TopupService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/20.
 */
@Service
public class TopupServiceImpl implements TopupService {

    @Resource
    private TopupDao topupDao;

    @Resource
    private PatientDao patientDao;


    @Override
    public String addOneTopupRecord(TopupBean topupBean) {
        PatientBean patientBean = patientDao.getPatientById(topupBean.getPid());
        topupBean.setAfterBalance(patientBean.getBalance());
        int result = topupDao.insert(topupBean);
        if (result > 0) {
            return "充值记录添加成功";
        } else {
            return "充值记录添加失败";
        }
    }

    @Override
    public String queryTopupReord(QueryTopupBean queryTopupBean) {
        int topupRecordCount = topupDao.getTopupRecordCountByParam(queryTopupBean);
        List<TopupBean> topupRecordList = topupDao.getTopupRecordByParam(queryTopupBean);


        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", topupRecordCount);
        jsonObject.put("rows", topupRecordList);
        return jsonObject.toString();
    }
}
