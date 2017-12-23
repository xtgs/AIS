package com.grid;

import com.grid.dao.UserScoreDao;
import com.grid.entity.QueryUserScoreBean;
import com.grid.entity.UserScoreBean;
import com.grid.service.UserScoreService;
import org.junit.Test;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/22.
 */
public class UserScoreTest extends BaseTest {
    @Resource
    private UserScoreDao userScoreDao;

    @Resource
    private UserScoreService userScoreService;

    @Test
    public void getUserScoreDaoTest() {
        QueryUserScoreBean queryUserScoreBean = new QueryUserScoreBean();
        List<UserScoreBean> scoreMap = userScoreDao.getUserScoreByParam(queryUserScoreBean);
        for (UserScoreBean userScoreBean : scoreMap) {
            System.out.println(userScoreBean);
        }
    }

    @Test
    public void getUserhScoreByParamTest() {
        QueryUserScoreBean queryUserScoreBean = new QueryUserScoreBean();
//        String userScoreBeanList = userScoreService.getUserScoreByParam(queryUserScoreBean);

    }


}
