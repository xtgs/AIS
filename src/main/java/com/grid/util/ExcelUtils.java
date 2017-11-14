package com.grid.util;

/**
 * Created by wanghuijian on 17/9/5.
 */

public class ExcelUtils {


//    public static List<Dev> readXls(File file) throws IOException {
//
//        HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(file));
//
//        // 默认读取第一个Sheet
//        HSSFSheet sheet = workbook.getSheetAt(0);
//
//        List<Dev> devList = new ArrayList<Dev>();
//
//        // 第一列
//        // int firstRowNumber = 0;
//        // 最后一列
//        int lastRowNumber = sheet.getLastRowNum();
//
//        // 循环读取每一行
//        // 第0行是表头，不要，从第1行开始
//        for (int i = 1; i <= lastRowNumber; i++) {
//            Dev dev = new Dev();
//
//            HSSFRow row = sheet.getRow(i);
//            // 这一行有多少个单元格
//            int lastCellNumber = row.getLastCellNum();
//
//
//            // 循环读取单元格
//            for (int j = 0; j < lastCellNumber; j++) {
//                HSSFCell cell = row.getCell(j);
//                int cellType = cell.getCellType();
//
//                if (cellType == 0) {
//                    // 数字类型
//                    int value = (int) cell.getNumericCellValue();
//                    if (j == 0) {
//                        // 每一行第一个单元格是序号id
//                        setPartEquipmentInfo(dev, j, value);
//                    } else {
//                        // 只要不是序号，其他一律转化成String存储
//                        setPartEquipmentInfo(dev, j, value);
//                    }
//                } else if (cellType == 1) {
//                    // 字符
//                    String value = cell.getStringCellValue();
//                    setPartEquipmentInfo(dev, j, value);
//                }
//            }
//
//            devList.add(dev);
//        }
//
//        return devList;
//    }
//
//
//    public static List<Dev> readXlsx(File file) throws IOException {
//
//        XSSFWorkbook workbook = new XSSFWorkbook(new FileInputStream(file));
//
//        // 默认读取第一个Sheet
//        XSSFSheet sheet = workbook.getSheetAt(0);
//
//        List<Dev> devList = new ArrayList<Dev>();
//
//        // 第一列
//        // int firstRowNumber = 0;
//        // 最后一列
//        int lastRowNumber = sheet.getLastRowNum();
//
//        // 循环读取每一行
//        // 第0行是表头，不要，从第1行开始
//        for (int i = 1; i <= lastRowNumber; i++) {
//            Dev equipmentInfo = new Dev();
//
//            XSSFRow row = sheet.getRow(i);
//            // 这一行有多少个单元格
//            int lastCellNumber = row.getLastCellNum();
//
//
//            // 循环读取单元格
//            for (int j = 0; j < lastCellNumber; j++) {
//                XSSFCell cell = row.getCell(j);
//                int cellType = cell.getCellType();
//
//                if (cellType == 0) {
//                    // 数字类型
//                    int value = (int) cell.getNumericCellValue();
//                    if (j == 0) {
//                        // 每一行第一个单元格是序号id
//                        setPartEquipmentInfo(equipmentInfo, j, value);
//                    } else {
//                        // 只要不是序号，其他一律转化成String存储
//                        setPartEquipmentInfo(equipmentInfo, j, value);
//                    }
//                } else if (cellType == 1) {
//                    // 字符
//                    String value = cell.getStringCellValue();
//                    setPartEquipmentInfo(equipmentInfo, j, value);
//                }
//            }
//
//            devList.add(equipmentInfo);
//        }
//
//        return devList;
//    }
//
//
//    private static void setPartEquipmentInfo(Dev dev, int position, Object value) {
//        switch (position) {
//            case 0:
//                // 序号
//                dev.setVid(value + "");
//                break;
//            case 1:
//                // construction_type
//                dev.setBuildType(value + "");
//                break;
//            case 2:
//                // operation_group
//                dev.setOperationGroup(value + "");
//                break;
//            case 3:
//                // system
//                dev.setDeployedSystem(value + "");
//                break;
//            case 4:
//                // equipment_name
//                dev.setDevName(value + "");
//                break;
//            case 5:
//                // operation_department
//                dev.setOperationDepart(value + "");
//                break;
//            case 6:
//                // room
//                dev.setMachineRoom(value + "");
//                break;
//            case 7:
//                // cabinet
//                dev.setDevNum(value + "");
//                break;
//            case 8:
//                // location
//                dev.setInstallLocation(value + "");
//                break;
//            case 9:
//                // equipment_type
//                dev.setDevType(value + "");
//                break;
//            case 10:
//                // equipment_model
//                dev.setDevModel(value + "");
//                break;
//            case 11:
//                // equipment_brand
//                dev.setBrand(value + "");
//                break;
//            case 12:
//                // person_in_charge
//                dev.setDevManagePerson(value + "");
//                break;
//            case 13:
//                dev.setDevManagePhone(value + "");
//                break;
//            case 14:
//                dev.setBusinessMan(value + "");
//                break;
//            case 15:
//                dev.setBusinessPhone(value + "");
//                break;
//            case 16:
//                // support_service
//                dev.setServiceLinkman(value + "");
//                break;
//            case 17:
//                dev.setServicePhone(value + "");
//                break;
//            case 18:
//                dev.setPowerNum(value + "");
//                break;
//            case 19:
//                dev.setPower(value + "");
//                break;
//        }
//    }
//
//
//    public static void exportXls(File file, List<Dev> devList) throws IOException {
//        HSSFWorkbook workbook = new HSSFWorkbook();
//
//        HSSFSheet sheet = workbook.createSheet();
//
//        List<String> headList = new ArrayList<String>();
//        headList.add("建设类型");
//        headList.add("运维组");
//        headList.add("部署应用系统");
//        headList.add("设备名称");
//        headList.add("运维部门");
//        headList.add("所在机房");
//        headList.add("机柜设备编号");
//        headList.add("安装位置");
//        headList.add("设备类型");
//        headList.add("设备型号");
//        headList.add("品牌");
//        headList.add("设备负责人");
//        headList.add("设备负责人联系方式");
//        headList.add("业务部门联系人");
//        headList.add("业务部门联系方式");
//        headList.add("服务商联系人");
//        headList.add("服务商联系方式");
//        headList.add("电源数量");
//        headList.add("电源功率");
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
//        for (int i = 0; i < devList.size(); i++) {
//            // 某一行 这里要用 i+1 因为第一行是表头
//            HSSFRow row = sheet.createRow(i + 1);
//
//            Dev dev = devList.get(i);
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
//
//
//    public static void exportXlsx(File file, List<Dev> equipmentInfoList) throws IOException {
//        XSSFWorkbook workbook = new XSSFWorkbook();
//
//        XSSFSheet sheet = workbook.createSheet();
//        List<String> headList = new ArrayList<String>();
//        headList.add("建设类型");
//        headList.add("运维组");
//        headList.add("部署应用系统");
//        headList.add("设备名称");
//        headList.add("运维部门");
//        headList.add("所在机房");
//        headList.add("机柜设备编号");
//        headList.add("安装位置");
//        headList.add("设备类型");
//        headList.add("设备型号");
//        headList.add("品牌");
//        headList.add("设备负责人");
//        headList.add("设备负责人联系方式");
//        headList.add("业务部门联系人");
//        headList.add("业务部门联系方式");
//        headList.add("服务商联系人");
//        headList.add("服务商联系方式");
//        headList.add("电源数量");
//        headList.add("电源功率");
//
//        // 第一行是表头
//        XSSFRow rowHeader = sheet.createRow(0);
//        rowHeader.createCell(0).setCellValue("序号");
//        for (int i = 0; i < headList.size(); i++) { //GridDevices.headNameList.size()
//            XSSFCell cell = rowHeader.createCell(i + 1);
//            cell.setCellValue(headList.get(i));//GridDevices.headNameList.get(i)
//        }
//
//        // 实际数据
//        for (int i = 0; i < equipmentInfoList.size(); i++) {
//            // 某一行 这里要用 i+1 因为第一行是表头
//            XSSFRow row = sheet.createRow(i + 1);
//
//            Dev dev = equipmentInfoList.get(i);
//
//            // 第0格 序号
//            XSSFCell cell0 = row.createCell(0);
//            cell0.setCellValue(i + 1);
//
//            // 第1格
//            XSSFCell cell1 = row.createCell(1);
//            cell1.setCellValue(dev.getBuildType() + "");
//
//            // 第2格
//            XSSFCell cell2 = row.createCell(2);
//            cell2.setCellValue(dev.getOperationGroup() + "");
//
//            // 第3格
//            XSSFCell cell3 = row.createCell(3);
//            cell3.setCellValue(dev.getDeployedSystem() + "");
//
//            // 第4格
//            XSSFCell cell4 = row.createCell(4);
//            cell4.setCellValue(dev.getDevName() + "");
//
//            // 第5格
//            XSSFCell cell5 = row.createCell(5);
//            cell5.setCellValue(dev.getOperationDepart() + "");
//
//            // 第6格
//            XSSFCell cell6 = row.createCell(6);
//            cell6.setCellValue(dev.getMachineRoom() + "");
//
//            // 第7格
//            XSSFCell cell7 = row.createCell(7);
//            cell7.setCellValue(dev.getDevNum() + "");
//
//            // 第8格
//            XSSFCell cell8 = row.createCell(8);
//            cell8.setCellValue(dev.getInstallLocation() + "");
//
//            // 第9格
//            XSSFCell cell9 = row.createCell(9);
//            cell9.setCellValue(dev.getDevType() + "");
//
//            // 第10格
//            XSSFCell cell10 = row.createCell(10);
//            cell10.setCellValue(dev.getDevModel() + "");
//
//            // 第11格
//            XSSFCell cell11 = row.createCell(11);
//            cell11.setCellValue(dev.getBrand() + "");
//
//            // 第12格
//            XSSFCell cell12 = row.createCell(12);
//            cell12.setCellValue(dev.getDevManagePerson() + "");
//
//            // 第13格
//            XSSFCell cell13 = row.createCell(13);
//            cell13.setCellValue(dev.getDevManagePhone() + "");
//
//            // 第14格
//            XSSFCell cell14 = row.createCell(14);
//            cell14.setCellValue(dev.getBusinessMan() + "");
//
//            // 第15格
//            XSSFCell cell15 = row.createCell(15);
//            cell15.setCellValue(dev.getBusinessPhone() + "");
//
//            // 第16格
//            XSSFCell cell16 = row.createCell(16);
//            cell16.setCellValue(dev.getServiceLinkman() + "");
//
//            // 第17格
//            XSSFCell cell17 = row.createCell(17);
//            cell17.setCellValue(dev.getServicePhone() + "");
//
//            // 第18格
//            XSSFCell cell18 = row.createCell(18);
//            cell18.setCellValue(dev.getPowerNum() + "");
//
//            // 第19格
//            XSSFCell cell19 = row.createCell(19);
//            cell19.setCellValue(dev.getPower() + "");
//        }
//
//        // 写入文件
//        file.createNewFile();
//        FileOutputStream fileOutputStream = FileUtils.openOutputStream(file);
//        workbook.write(fileOutputStream);
//        fileOutputStream.close();
//    }

}

