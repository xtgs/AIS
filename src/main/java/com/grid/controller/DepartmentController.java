package com.grid.controller;

import com.grid.entity.QueryDepartmentScoreBean;
import com.grid.service.DepartmentScoreService;
import com.grid.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by wanghuijian on 17/12/26.
 */
@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Resource
    private DepartmentScoreService departmentScoreService;

    @RequestMapping("/fwdDepartmentScorePage")
    public String fwdDepartmentScorePage(HttpServletRequest request, HttpServletResponse response) {
        return "/department/departmentScore";
    }

    @RequestMapping("/departmentScore")
    public void departmentScore(HttpServletRequest request, HttpServletResponse response, QueryDepartmentScoreBean queryDepartmentScoreBean) {
        try {
            String result = departmentScoreService.getDepartmentScore(queryDepartmentScoreBean);
            ResponseUtil.writeMsg(response, result);
        } catch(Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，查询所有用户和管理员信息失败");
        }
    }
}
