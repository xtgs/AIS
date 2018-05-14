package com.grid;

import com.grid.entity.PrintBean;
import com.grid.util.PrintUtil;
import org.apache.xmlbeans.XmlException;
import org.junit.Test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;

/**
 * Created by wanghuijian on 18/4/7.
 */
public class PrintTest extends BaseTest {

    @Test
    public void printTest() throws IOException, XmlException {
        PrintUtil printUtil = new PrintUtil();
        PrintBean printBean = new PrintBean();
        printBean.setPid("a100001");
        printBean.setBillName("aa");
        printBean.setPatientName("小李");
        printBean.setDocterName("医生王");
        printBean.setItemName("某服务");
        printBean.setOriginalPrice(new BigDecimal(100));
        printBean.setRealPrice(new BigDecimal(90));
        printBean.setAfterBalance(new BigDecimal(910));
        printUtil.createWord(printBean);

//        try {
//            printUtil.createWord("aa", "李", "王", "按摩", new BigDecimal(100), new BigDecimal(90), new BigDecimal(980));
//        } catch (IOException e) {
//            e.printStackTrace();
//        } catch (XmlException e) {
//            e.printStackTrace();
//        }
    }

    @Test
    public void myTest() throws FileNotFoundException {
        String filePath = new File("").getAbsolutePath();
        System.out.println(filePath);
        if (!new File(filePath + "/bill").exists()) {
            new File(filePath + "/bill").mkdir();
        }
        FileOutputStream out = new FileOutputStream(new File(filePath + "/bill/aaaa.doc"));

    }
}
