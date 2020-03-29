package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Test03 {
	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		Connection connection =null;
		PreparedStatement ps = null;
		
		String[] sql = {
		"insert into employee(name ,mail ,money ,num  ,insert_date)values('차남훈','fwqw@.com',200,acc_seq.nextval,'2020-03-29')",
		"insert into employee(name ,mail ,money ,num  ,insert_date)values('손일규','avbqw@.com',300,acc_seq.nextval,'2020-03-29')",
		"insert into employee(name ,mail ,money ,num  ,insert_date)values('조수현','qww@.com',400,acc_seq.nextval,'2020-03-29')"
		};
		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		
		 for (int i = 0; i < 3; i++) {
			 
			 ps = connection.prepareStatement(sql[i]);
			 ps.execute();//데이터입력할때  commit도 자동으로 실행이 된다.
		 }


		 
		System.out.println("데이터 입력 완료!");
		
		}catch(ClassNotFoundException e) {
			e.printStackTrace(); // OracleDriver클래스가 없을때 발생
		}catch(SQLException e) {
			e.printStackTrace(); // 커넥션(DB와 연동)하는 과정에서 예외 발생
		}finally {
			try {
			if(ps!=null) {
				ps.close();	
			}
			if(connection!=null) {
				connection.close();	
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
		}
}
