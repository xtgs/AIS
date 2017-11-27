package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.PatientDao;
import com.grid.entity.PaginationParamBean;
import com.grid.entity.PatientBean;
import com.grid.entity.QueryPatientParamBean;
import com.grid.service.PatientService;
import com.grid.util.PaginationUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/11/16.
 */

@Service
public class PatientServiceImpl implements PatientService {

    @Resource
    private PatientDao patientDao;


    @Override
    public String getPatientByParam(QueryPatientParamBean queryPatientParamBean, String page, String rows, String sort, String order) {
        List<PatientBean> patients = null;
        Integer queryPatientByParamCount = 0;
        String sqlSortName = null;
        if (sort == null) {
            sqlSortName = "pid";
        } else if (sort.equals("cardId")) {
            sqlSortName = "card_id";
        } else {
            sqlSortName = "pid";
        }

        if (order == null || order.length() == 0) {
            order="asc";
        }

        try{
            queryPatientByParamCount = patientDao.getPatientByParamCount(queryPatientParamBean);
            // totalCount = Integer.parseInt(allMasterCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            // userBeans = userDao.listAllUserAndAdmin(paramBean); //sqlSession.selectList("com.grid.entity.User.listAllUserAndAdmin", paramBean);
            queryPatientParamBean.setStartnum(paramBean.getStartnum());
            queryPatientParamBean.setGetrows(paramBean.getGetrows());

            queryPatientParamBean.setSort(sqlSortName);
            queryPatientParamBean.setOrder(order);
            patients = patientDao.getPatientByParam(queryPatientParamBean);
        }catch (Exception e){
            e.printStackTrace();
            // throw new BgException("出现异常，查询所有用户和管理员信息失败");
        }finally {
            // MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", queryPatientByParamCount);
        jsonObject.put("rows", patients);
        return jsonObject.toString();
    }
}
