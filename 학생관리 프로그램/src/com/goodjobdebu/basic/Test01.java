package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Test01 {
	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection connection = DriverManager.getConnection(url,id,password);
		
		PreparedStatement ps = connection.prepareStatement("CREATE SEQUENCE student_seq NOCACHE");
		ps.execute();
		
		ps.close();
		connection.close();
		
		System.out.println("시퀀스 생성 완료!");
		
		}catch(ClassNotFoundException e) {
			e.printStackTrace(); // OracleDriver클래스가 없을때 발생
		}catch(SQLException e) {
			e.printStackTrace(); // 커넥션(DB와 연동)하는 과정에서 예외 발생
		}
	}

}
