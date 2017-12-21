package com.grid.service;

import com.grid.entity.QueryTopupBean;
import com.grid.entity.TopupBean;

/**
 * Created by wanghuijian on 17/12/20.
 */
public interface TopupService {
    String addOneTopupRecord(TopupBean topupBean);

    String queryTopupReord(QueryTopupBean queryTopupBean);
}
