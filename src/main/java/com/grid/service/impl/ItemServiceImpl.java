package com.grid.service.impl;

import com.grid.dao.ItemDao;
import com.grid.entity.ItemBean;
import com.grid.service.ItemService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/26.
 */
@Service
public class ItemServiceImpl implements ItemService {
    private static final org.slf4j.Logger LOG = LoggerFactory.getLogger(ItemServiceImpl.class);

    @Resource
    private ItemDao itemDao;



    @Override
    public List<ItemBean> getItemList() {
        return itemDao.getItemList();
    }

    @Override
    public ItemBean getItemById(String iid) {
        try {
            ItemBean itemBean = itemDao.getItemById(iid);
            LOG.info(itemBean + "获取item成功");
            return itemBean;
        } catch (Exception e) {
            LOG.error("获取item失败");
            return null;
        }
    }

    @Override
    public int insert(ItemBean itemBean) {
        try {
            int result = itemDao.insert(itemBean);
            if (result > 0) {
                LOG.info(itemBean + "项目插入成功!");
                return 0;
            } else {
                LOG.error(itemBean + "数据库异常,项目插入失败!");
                return -1;
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), itemBean + "程序异常,项目插入失败!");
            return -1;
        }
    }

    @Override
    public int update(ItemBean itemBean) {
        try {
            int result = itemDao.update(itemBean);
            if (result > 0) {
                LOG.info(itemBean + "项目修改成功!");
                return 0;
            } else {
                LOG.error("数据库异常,项目修改失败!");
                return -1;
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), itemBean + "程序异常,项目修改失败!");
            return -1;
        }
    }

    @Override
    public int delete(String  iid) {
        try {
            int result = itemDao.delete(iid);
            if (result > 0) {
                LOG.info("项目[" + iid + "]删除成功!");
                return 0;
            } else {
                LOG.error("数据库异常,项目删除失败!");
                return -1;
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), "程序异常,项目[" + iid + "]删除失败!");
            return -1;
        }
    }
}
