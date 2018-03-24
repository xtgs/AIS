package com.grid.controller;

import com.google.gson.Gson;
import com.grid.entity.ItemBean;
import com.grid.service.ItemService;
import com.grid.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by wanghuijian on 17/12/26.
 */
@Controller
@RequestMapping("/item")
public class ItemController {

    @Resource
    private ItemService itemService;

    @RequestMapping("/fwdManageItemPage")
    public String fwdManageItemPage(HttpServletRequest request, HttpServletResponse response) {
        return "/item/manageItem";
    }



    @RequestMapping("/fwdModifyItemPage")
    public String fwdModifyItemPage(HttpServletRequest request, HttpServletResponse response, @RequestParam("iid") String iid) {
        request.setAttribute("iid", iid);
        return "/item/modifyItem";
    }

    @RequestMapping("/fwdAddItemPage")
    public String fwdAddItemPage(HttpServletRequest request, HttpServletResponse response) {
        return "/item/addItem";
    }


    @RequestMapping("/getItemById")
    public void getItemById(@RequestParam("iid") String iid, HttpServletRequest request, HttpServletResponse response) {
        ItemBean itemBean = itemService.getItemById(iid);
        if (itemBean != null) {
            Gson gson = new Gson();
            String itemJson = gson.toJson(itemBean);
            ResponseUtil.writeMsg(response, itemJson);
        } else {
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，获取项目失败");
        }
    }

    @RequestMapping("/delete")
    public void delete(@RequestParam("iid") String iid, HttpServletRequest request, HttpServletResponse response) {
        int result = itemService.delete(iid);
        if (result < 0) {
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，删除项目失败");
        } else {
            ResponseUtil.writeMsg(response, "项目删除成功");
        }
    }

    @RequestMapping("/update")
    public void update(HttpServletRequest request, HttpServletResponse response) {
        ItemBean itemBean = new ItemBean();
        itemBean.setIid(request.getParameter("iid"));
        itemBean.setName(request.getParameter("name"));
        itemBean.setPrice(new BigDecimal(request.getParameter("price")));
        int result = itemService.update(itemBean);
        if (result < 0) {
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，更新项目失败");
        } else {
            ResponseUtil.writeMsg(response, "项目修改成功");
        }
    }

    @RequestMapping("/insert")
    public void insert(ItemBean itemBean, HttpServletRequest request, HttpServletResponse response) {
        int result = itemService.insert(itemBean);
        if (result < 0) {
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，插入项目失败");
        } else {
            ResponseUtil.writeMsg(response, "项目插入成功");
        }
    }

    @RequestMapping("/getItemList")
    @ResponseBody
    public List<ItemBean> getItemList() {
        List<ItemBean> itemBeanList = itemService.getItemList();
        for (ItemBean itemBean:itemBeanList) {
            String price = itemBean.getPrice().toString();
            itemBean.setId_price(itemBean.getIid() + ":" + price);
        }
        return itemBeanList;
    }


}
