package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.PatientDao;
import com.grid.entity.*;
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
        if (sort == null || sort.length() == 0) {
            sqlSortName = "pid";
        } else if (sort.equals("cardId")) {
            sqlSortName = "card_id";
        } else if (sort.equals("createDate")) {
            sqlSortName = "create_date";
        } else {
            sqlSortName = sort;
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

    @Override
    public PatientBean getPatientById(String pid) {
        return patientDao.getPatientById(pid);
    }

    @Override
    public String saveAddPatient(PatientBean patientBean) {
        //根据身份证号获取出生年月
        if (patientBean.getCardId().length() == 18) {
            patientBean.setBirthday(getBirthdayByCardId(patientBean.getCardId()));
        }
        int result = patientDao.insert(patientBean);
        if (result > 0) {
            return "添加新客户成功";
        } else {
            return "添加新客户失败";
        }
    }

    @Override
    public String saveModifyPatient(PatientBean patientBean) {
        if (patientBean.getCardId().length() == 18) {
            patientBean.setBirthday(getBirthdayByCardId(patientBean.getCardId()));
        }
        int result = patientDao.update(patientBean);
        if (result > 0) {
            return "修改客户信息成功";
        } else {
            return "修改客户信息失败";
        }
    }

    @Override
    public String deletePatientById(String pid) {
        int result = patientDao.deletePatientById(pid);
        if (result > 0) {
            return "删除客户条目成功";
        } else {
            return "删除客户条目失败";
        }
    }

    @Override
    public String chargeInBalance(ChargeBean chargeBean) {
        int result = patientDao.charge(chargeBean);
        if (result > 0) {
            return "消费成功";
        } else {
            return "消费失败";
        }
    }

    @Override
    public String topupInBalance(TopupBean topupBean) {
        int result = patientDao.topup(topupBean);
        if (result > 0) {
            return "充值成功";
        } else {
            return "充值失败";
        }
    }

    @Override
    public String getTradeRecordByParam(QueryTradeRecordBean queryTradeRecordBean, String page, String rows, String sort, String order) {
        List<TradeRecordBean> tradeRecordList = null;
        Integer tradeRecordCount = 0;
        String sqlSortName = null;
        if (sort == null || sort.length() == 0) {
            sqlSortName = "createTime";
        } else {
            sqlSortName = sort;
        }

        if (order == null || order.length() == 0) {
            order="desc";
        }

        try{
            tradeRecordCount = patientDao.getTradeRecordCountByParam(queryTradeRecordBean);
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            queryTradeRecordBean.setStartnum(paramBean.getStartnum());
            queryTradeRecordBean.setGetrows(paramBean.getGetrows());

            queryTradeRecordBean.setSort(sqlSortName);
            queryTradeRecordBean.setOrder(order);
            tradeRecordList = patientDao.getTradeRecordByParam(queryTradeRecordBean);
        }catch (Exception e){
            e.printStackTrace();
            // throw new BgException("出现异常，查询所有用户和管理员信息失败");
        }finally {
            // MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", tradeRecordCount);
        jsonObject.put("rows", tradeRecordList);
        return jsonObject.toString();
    }

    String getBirthdayByCardId(String cardId) {
        String birthYear = cardId.substring(6, 10);
        String birthMonth = cardId.substring(10, 12);
        String birthDay = cardId.substring(12, 14);
        String birthday = birthYear + "-" + birthMonth + "-" + birthDay;
        return birthday;
    }
}
