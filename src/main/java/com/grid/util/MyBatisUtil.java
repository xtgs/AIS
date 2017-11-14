package com.grid.util;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by Administrator on 2017/3/28.
 */
public class MyBatisUtil {
    private static SqlSessionFactory factory;
    private static ApplicationContext ctx = null;
    static {
            if (ctx == null) {
//                ctx = new ClassPathXmlApplicationContext("classpath:aliyun-mybatis.xml");
                ctx = new ClassPathXmlApplicationContext("classpath:spring-mybatis.xml");
            }
            factory = (SqlSessionFactory)ctx.getBean("sqlSessionFactory");
    }
    public static SqlSession createSession() {
        return factory.openSession();
    }

    public static void closeSession(SqlSession session) {
        if(session!=null) session.close();
    }
}
