package com.grid.dao;

import com.grid.entity.QueryUserScoreBean;
import com.grid.entity.UserScoreBean;

import java.util.List;

/**
 * Created by wanghuijian on 17/12/22.
 */
public interface UserScoreDao {
    List<UserScoreBean> getUserScoreByParam(QueryUserScoreBean queryUserScoreBean);

    List<UserScoreBean> getUidAndName(QueryUserScoreBean queryUserScoreBean);
    int getUserNum(QueryUserScoreBean queryUserScoreBean);


}
