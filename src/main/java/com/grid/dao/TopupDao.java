package com.grid.dao;


import com.grid.entity.QueryTopupBean;
import com.grid.entity.TopupBean;

import java.util.List;

/**
 * Created by wanghuijian on 17/12/20.
 */
public interface TopupDao {

    int insert(TopupBean topupBean);

    List<TopupBean> getTopupRecordByParam(QueryTopupBean queryTopupBean);
    int getTopupRecordCountByParam(QueryTopupBean queryTopupBean);
}
