package com.grid.service;

import com.grid.entity.QueryUserScoreBean;

/**
 * Created by wanghuijian on 17/12/22.
 */
public interface UserScoreService {
    String getUserScoreByParam(QueryUserScoreBean queryUserScoreBean, String page, String rows);
}
