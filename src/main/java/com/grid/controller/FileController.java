package com.grid.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by wanghuijian on 17/9/6.
 */
@Controller
@RequestMapping("/file")
public class FileController {


//    @RequestMapping("/upload.do")
//    public void upload(@RequestParam(value="uploadExcel") MultipartFile mFile, HttpServletRequest request, HttpServletResponse response){
//        String rootPath = request.getSession().getServletContext().getRealPath(File.separator);
//        //File file = new File(rootPath);
//
//
//        String fileName = mFile.getOriginalFilename();
////        String fileName = new Date().getTime()+".jpg";
//        // System.out.println(rootPath);
//        File targetFile = new File(rootPath, fileName);
//        if(!targetFile.exists()){
//            targetFile.mkdirs();
//        }
//        //保存
//        try {
//            mFile.transferTo(targetFile);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//
//        boolean result = false;
//        LoginUserBean loginUserBean = getLoginUserBean(request);
//        // 只有管理员可以不经过审核直接添加设备,其他人添加设备需要进行审核
//        if (loginUserBean.getUtype().equals(Constant.UserType_Admin)) {
//            result = devService.upload(targetFile);
//            if(result){
//                ResponseUtil.writeMsg(response,"数据导入成功");
//            }else{
//                ResponseUtil.writeFailMsgToBrowse(response,"数据导入失败");
//            }
//        } else {
//            result = operateService.upload(targetFile, loginUserBean.getLoginname());
//            if(result){
//                ResponseUtil.writeMsg(response,"输入导入成功,进入审核阶段!");
//            }else{
//                ResponseUtil.writeFailMsgToBrowse(response,"数据导入失败");
//            }
//        }
//
//
//
//
////        boolean result = devService.upload(targetFile);
////        if (result == true) {
////            ResponseUtil.writeMsg(response,"数据导入成功!");
////        } else {
////            ResponseUtil.writeFailMsgToBrowse(response,"数据导入失败!");
////        }
////        List<Dev> secUserList = ieportService.importFile(mFile, rootPath);
////
////        ModelAndView mv = new ModelAndView();
////        mv.addObject("type", "import");
////        mv.addObject("secUserList", secUserList);
////        mv.setViewName("/success");
////        return mv;
//    }
//
//    @RequestMapping("/export.do")
//    public ModelAndView exportFile(HttpServletResponse response) {
//        //ieportService.exportFile(response);
//
//        ModelAndView mv = new ModelAndView();
//        mv.addObject("type", "export");
//        mv.setViewName("/success");
//        return mv;
//    }
//
//    @RequestMapping("/download.do")
//    public ResponseEntity<byte[]> download(HttpServletRequest req, HttpServletResponse resp,
//                                           //@RequestParam("downloadExcel") String filename,
//                                           Model model)throws Exception {
//        String filename = "export.xls";
//        //下载文件路径
//        String path = req.getSession().getServletContext().getRealPath(File.separator);
//        File file = new File(path + File.separator + filename);
//
//
//
//        String page = req.getParameter("page");
//        String rows = req.getParameter("rows");
//        String sort = req.getParameter("sort");
//        String order = req.getParameter("order");
//        QueryDevParamBean queryDevParamBean = new QueryDevParamBean();
//        String buildTypeCondition = new String(req.getParameter("buildTypeCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (buildTypeCondition != null && buildTypeCondition.length() > 0) {
//            queryDevParamBean.setBuildTypeCondition(buildTypeCondition);
//        }
//        String brandCondition = new String(req.getParameter("brandCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (brandCondition != null && brandCondition.length() > 0) {
//            queryDevParamBean.setBrandCondition(brandCondition);
//        }
//        String devModelCondition = new String(req.getParameter("devModelCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (devModelCondition != null && devModelCondition.length() > 0) {
//            queryDevParamBean.setDevModelCondition(devModelCondition);
//        }
//
//        String devPersonCondition = new String(req.getParameter("devPersonCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (devPersonCondition != null && devPersonCondition.length() > 0) {
//            queryDevParamBean.setDevPersonCondition(devPersonCondition);
//        }
//        String devTypeCondition = new String(req.getParameter("devTypeCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (devTypeCondition != null && devTypeCondition.length() > 0) {
//            queryDevParamBean.setDevTypeCondition(devTypeCondition);
//        }
//
//        String operationDepartCondition = new String(req.getParameter("operationDepartCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (operationDepartCondition != null && operationDepartCondition.length() > 0) {
//            queryDevParamBean.setOperationDepartCondition(operationDepartCondition);
//        }
//        String operationGroupCondition = new String(req.getParameter("operationGroupCondition").getBytes("ISO-8859-1"),"UTF-8");
//        if (operationGroupCondition != null && operationGroupCondition.length() > 0) {
//            queryDevParamBean.setOperationGroupCondition(operationGroupCondition);
//        }
//
//        String result = null;
//        String queryByParamFlag = req.getParameter("queryByParamFlag");
//        // result = devService.getDevByParam(queryDevParamBean, page, rows, sort, order, );
//
//
//        int downloadItems = devService.export(file, queryDevParamBean, sort, order);
////        if (downloadItems > 0) {
////            ResponseUtil.writeMsg(resp, "已成功导出"+downloadItems+"条台账信息");
////        } else {
////            ResponseUtil.writeFailMsgToBrowse(resp, "导出失败!");
////        }
//        HttpHeaders headers = new HttpHeaders();
//        //下载显示的文件名，解决中文名称乱码问题
//        String downloadFielName = new String(filename.getBytes("UTF-8"),"iso-8859-1");
//        //通知浏览器以attachment（下载方式）打开图片
//        headers.setContentDispositionFormData("attachment", downloadFielName);
//        //application/octet-stream ： 二进制流数据（最常见的文件下载）。
//        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
//                headers, HttpStatus.CREATED);
//    }
//
//    //rname是请求下载的文件名
//    @RequestMapping("/downFile")
//    public ResponseEntity<byte[]> download(String rname) throws IOException {
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//        headers.setContentDispositionFormData("attachment", "download.xsl");
//        //存放文件的路径
//        String path = "Users/wanghuijian/download.xsl";
//        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(new File(path)), headers, HttpStatus.CREATED);
//    }
//
//    @RequestMapping("/test")
//    public static void test(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
//        String h1 = req.getParameter("hello");
//        String h2 = URLDecoder.decode(req.getParameter("hello"), "utf-8");
//        String h3 = new String(h1.getBytes("ISO-8859-1"),"UTF-8");
//        ResponseUtil.writeMsg(resp, h1);
//
//    }
//
//
//    public LoginUserBean getLoginUserBean(HttpServletRequest resq) {
//        HttpSession sessionObj = resq.getSession(false);
//        LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
//        return userBean;
//    }


}
