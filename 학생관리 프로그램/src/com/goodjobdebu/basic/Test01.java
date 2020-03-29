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
		
		System.out.println("������ ���� �Ϸ�!");
		
		}catch(ClassNotFoundException e) {
			e.printStackTrace(); // OracleDriverŬ������ ������ �߻�
		}catch(SQLException e) {
			e.printStackTrace(); // Ŀ�ؼ�(DB�� ����)�ϴ� �������� ���� �߻�
		}
	}

}
