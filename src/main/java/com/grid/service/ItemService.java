package com.grid.service;

import com.grid.entity.ItemBean;

import java.util.List;

/**
 * Created by wanghuijian on 17/12/26.
 */
public interface ItemService {
     List<ItemBean> getItemList();
     ItemBean getItemById(String iid);
     int insert(ItemBean itemBean);
     int update(ItemBean itemBean);
     int delete(String iid);
}
