package com.grid.util;

import com.grid.exception.BgException;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.ibatis.session.SqlSession;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by Administrator on 2017/3/15.
 * 序列生成工具
 */
public class SeqUtils {
    /**
     * 根据指定序列的名称，获取当前序列的下一个值
     * @param seqName 序列名称
     * @return 序列的下一个值
     */
    public String getSeqNextVal(String seqName) throws BgException {
        SqlSession sqlSession = null;
        String nextVal = "";
        Connection conn = null;
        QueryRunner runner = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            conn = sqlSession.getConnection();
            conn.setAutoCommit(true);
            runner = new QueryRunner();
            Object[] results = null;
            results = runner.query(conn,"select nextval('" + seqName + "')", new ArrayHandler());
            nextVal = results[0].toString();
            conn.setAutoCommit(false);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.setAutoCommit(false);
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            throw new BgException(e.getMessage());
        }finally {
            try {
                conn.setAutoCommit(false);
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            MyBatisUtil.closeSession(sqlSession);
        }
        return nextVal;
    }

    /**
     * 本方法用0补足序列所缺的位数，从前开始补。例如  2 补全为 00002
     * @param val 要补全0的字符串
     * @param length 补全之后应该达到的长度
     * @return
     */
    public static String autoAttachZeroFromStart(String val, int length){
        //计算需要补0的个数
        int diff = length - val.length();
        StringBuffer resultBF = new StringBuffer();
        for(int i = 0; i < diff; i++){
            resultBF.append("0");
        }
        resultBF.append(val);
        return  resultBF.toString();
    }
}
