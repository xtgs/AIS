package com.grid;

import com.grid.dao.ItemDao;
import com.grid.entity.ItemBean;
import org.junit.Test;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by wanghuijian on 18/3/20.
 */
public class ItemTest extends BaseTest {
    @Resource
    private ItemDao itemDao;

    @Test
    public void insertTest() {
        ItemBean itemBean = new ItemBean();
        itemBean.setName("anmo");
        itemBean.setPrice(new BigDecimal(100));
        itemDao.insert(itemBean);
    }

    @Test
    public void getItemListTest() {
        List<ItemBean> itemBeanList = itemDao.getItemList();
        System.out.println(itemBeanList);
    }
}
