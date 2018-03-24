package com.grid.dao;

import com.grid.entity.ItemBean;

import java.util.List;

/**
 * Created by wanghuijian on 17/12/25.
 */
public interface ItemDao {
    int insert(ItemBean itemBean);
    int delete(String iid);
    int update(ItemBean itemBean);
    ItemBean getItemById(String iid);
    List<ItemBean> getItemList();


}
