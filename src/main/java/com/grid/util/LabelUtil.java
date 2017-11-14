package com.grid.util;

/**
 * Created by wanghuijian on 17/11/14.
 */
public class LabelUtil {

//    public static void exportXls(File file, List<Label> labelList) throws IOException {
//        HSSFWorkbook workbook = new HSSFWorkbook();
//
//        HSSFSheet sheet = workbook.createSheet();
//
//
//
//
//        List<String> headList = new ArrayList<String>();
//        headList.add("设备名称");
//        headList.add("设备型号");
//        headList.add("运维部门");
//        headList.add("安装位置");
//        headList.add("设备负责人");
//        headList.add("设备负责人联系方式");
//        headList.add("业务部门联系人");
//        headList.add("业务部门联系方式");
//        headList.add("版本");
//        headList.add("标签生成时间");
//
//
//        // 第一行是表头
//        HSSFRow rowHeader = sheet.createRow(0);
//        rowHeader.createCell(0).setCellValue("序号");
//        for (int i = 0; i < headList.size(); i++) {
//            HSSFCell cell = rowHeader.createCell(i + 1);
//            cell.setCellValue(headList.get(i));
//        }
//
//        // 实际数据
//        for (int i = 0; i < labelList.size(); i++) {
//            // 某一行 这里要用 i+1 因为第一行是表头
//            HSSFRow row = sheet.createRow(i + 1);
//
//            Label label = labelList.get(i);
//
//            // 第0格 序号
//            HSSFCell cell0 = row.createCell(0);
//            cell0.setCellValue(i + 1);
//
//            // 第1格
//            HSSFCell cell1 = row.createCell(1);
//            cell1.setCellValue(dev.getBuildType() + "");
//
//            // 第2格
//            HSSFCell cell2 = row.createCell(2);
//            cell2.setCellValue(dev.getOperationGroup() + "");
//
//            // 第3格
//            HSSFCell cell3 = row.createCell(3);
//            cell3.setCellValue(dev.getDeployedSystem() + "");
//
//            // 第4格
//            HSSFCell cell4 = row.createCell(4);
//            cell4.setCellValue(dev.getDevName() + "");
//
//            // 第5格
//            HSSFCell cell5 = row.createCell(5);
//            cell5.setCellValue(dev.getOperationDepart() + "");
//
//            // 第6格
//            HSSFCell cell6 = row.createCell(6);
//            cell6.setCellValue(dev.getMachineRoom() + "");
//
//            // 第7格
//            HSSFCell cell7 = row.createCell(7);
//            cell7.setCellValue(dev.getDevNum() + "");
//
//            // 第8格
//            HSSFCell cell8 = row.createCell(8);
//            cell8.setCellValue(dev.getInstallLocation() + "");
//
//            // 第9格
//            HSSFCell cell9 = row.createCell(9);
//            cell9.setCellValue(dev.getDevType() + "");
//
//            // 第10格
//            HSSFCell cell10 = row.createCell(10);
//            cell10.setCellValue(dev.getDevModel() + "");
//
//            // 第11格
//            HSSFCell cell11 = row.createCell(11);
//            cell11.setCellValue(dev.getBrand() + "");
//
//            // 第12格
//            HSSFCell cell12 = row.createCell(12);
//            cell12.setCellValue(dev.getDevManagePerson() + "");
//
//            // 第13格
//            HSSFCell cell13 = row.createCell(13);
//            cell13.setCellValue(dev.getDevManagePhone() + "");
//
//            // 第14格
//            HSSFCell cell14 = row.createCell(14);
//            cell14.setCellValue(dev.getBusinessMan() + "");
//
//            // 第15格
//            HSSFCell cell15 = row.createCell(15);
//            cell15.setCellValue(dev.getBusinessPhone() + "");
//
//            // 第16格
//            HSSFCell cell16 = row.createCell(16);
//            cell16.setCellValue(dev.getServiceLinkman() + "");
//
//            // 第17格
//            HSSFCell cell17 = row.createCell(17);
//            cell17.setCellValue(dev.getServicePhone() + "");
//
//            // 第18格
//            HSSFCell cell18 = row.createCell(18);
//            cell18.setCellValue(dev.getPowerNum() + "");
//
//            // 第19格
//            HSSFCell cell19 = row.createCell(19);
//            cell19.setCellValue(dev.getPower() + "");
//
//
//        }
//
//        // 写入文件
//        file.createNewFile();
//        FileOutputStream fileOutputStream = FileUtils.openOutputStream(file);
//        workbook.write(fileOutputStream);
//        fileOutputStream.close();
//    }
}
