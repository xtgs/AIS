package com.grid.util;

import com.grid.entity.PrintBean;
import org.apache.poi.xwpf.usermodel.*;
import org.apache.xmlbeans.XmlException;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;

/**
 * Created by wanghuijian on 18/4/7.
 */
public class PrintUtil {

    public void createWord(PrintBean printBean) throws IOException, XmlException {
        //Blank Document
        XWPFDocument document= new XWPFDocument();

        //Write the Document in file system
        String billPath = printBean.getBillName();
        String filePath = new File("").getAbsolutePath();
        if (!new File(filePath + "/bill").exists()) {
            new File(filePath + "/bill").mkdir();
        }
        if (printBean.getBillName() == null) {
            printBean.setBillName("bill");
        }
        String newFilePath = filePath + "/bill/" + printBean.getBillName() + ".doc";
        File file = new File(newFilePath);
        FileOutputStream out = new FileOutputStream(file);

        //添加标题
        XWPFParagraph titleParagraph = document.createParagraph();
        //设置段落居中
        titleParagraph.setAlignment(ParagraphAlignment.CENTER);

        XWPFRun titleParagraphRun = titleParagraph.createRun();
        titleParagraphRun.setText("账单");
        titleParagraphRun.setColor("000000");
        titleParagraphRun.setFontSize(20);



        //换行
        XWPFParagraph paragraph1 = document.createParagraph();
        XWPFRun paragraphRun1 = paragraph1.createRun();
        paragraphRun1.setText("\r");


        //基本信息表格
        XWPFTable infoTable = document.createTable();
        //去表格边框
        infoTable.getCTTbl().getTblPr().unsetTblBorders();


        //列宽自动分割
        CTTblWidth infoTableWidth = infoTable.getCTTbl().addNewTblPr().addNewTblW();
        infoTableWidth.setType(STTblWidth.DXA);
        infoTableWidth.setW(BigInteger.valueOf(9072));


        //表格第一行
        XWPFTableRow infoTableRowZero = infoTable.getRow(0);

        infoTableRowZero.getCell(0).setText("");
        infoTableRowZero.addNewTableCell().setText("卡号");
        if (printBean.getPid() == null) {
            printBean.setPid("");
        }
        infoTableRowZero.addNewTableCell().setText(printBean.getPid());
        infoTableRowZero.addNewTableCell().setText("");


        //表格第一行
        XWPFTableRow infoTableRowOne = infoTable.createRow();
        infoTableRowOne.getCell(1).setText("客户姓名");
        if (printBean.getPatientName() != null) {
            infoTableRowOne.getCell(2).setText(printBean.getPatientName());
        }

        //表格第二行
        XWPFTableRow infoTableRowTwo = infoTable.createRow();
        infoTableRowTwo.getCell(1).setText("医师姓名");
        if (printBean.getDocterName() != null) {
            infoTableRowTwo.getCell(2).setText(printBean.getDocterName());
        }

        if (printBean.getTradeType().equals("1")) {   //消费
            XWPFTableRow infoTableRowType = infoTable.createRow();
            infoTableRowType.getCell(1).setText("交易类型");
            infoTableRowType.getCell(2).setText("消费");

            //表格第三行
            XWPFTableRow infoTableRowThree = infoTable.createRow();
            infoTableRowThree.getCell(1).setText("项目");
            if(printBean.getItemName() != null) {
                infoTableRowThree.getCell(2).setText(printBean.getItemName());
            }

            //表格第四行
            XWPFTableRow infoTableRowFour = infoTable.createRow();
            infoTableRowFour.getCell(1).setText("原价");
            if (printBean.getOriginalPrice() != null) {
                infoTableRowFour.getCell(2).setText(printBean.getOriginalPrice().toString() + "元");
            }

            //表格第五行
            XWPFTableRow infoTableRowFive = infoTable.createRow();
            infoTableRowFive.getCell(1).setText("实际价格");
            if (printBean.getRealPrice() != null) {
                infoTableRowFive.getCell(2).setText(printBean.getRealPrice().toString() + "元");
            }
        } else if (printBean.getTradeType().equals("2")) { //充值
            XWPFTableRow infoTableRowType = infoTable.createRow();
            infoTableRowType.getCell(1).setText("交易类型");
            infoTableRowType.getCell(2).setText("充值");


            XWPFTableRow infoTableRowThree = infoTable.createRow();
            infoTableRowThree.getCell(1).setText("充值金额");
            if(printBean.getTopupAmount() != null) {
                infoTableRowThree.getCell(2).setText(printBean.getTopupAmount() + "元");
            }
        }



        //表格第六行
        XWPFTableRow infoTableRowSix = infoTable.createRow();
        infoTableRowSix.getCell(1).setText("账户余额");
        if (printBean.getAfterBalance() != null) {
            infoTableRowSix.getCell(2).setText(printBean.getAfterBalance().toString() + "元");
        }



        document.write(out);
        out.close();
        System.out.println("create_table document written success.");
//        System.out.println(new File("bbb").getAbsoluteFile());
        Desktop.getDesktop().open(file);

    }
}



