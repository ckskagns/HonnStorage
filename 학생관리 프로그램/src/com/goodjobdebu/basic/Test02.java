package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Test02 {

	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		Connection connection =null;
		PreparedStatement ps = null;

		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		
		ps = connection.prepareStatement("create table employee(name varchar(10),mail varchar(10),money int,num int ,insert_date date)");
		ps.execute();
		 
		ps = connection.prepareStatement("CREATE SEQUENCE acc_seq NOCACHE");
		ps.execute();
		
		
		System.out.println("������ ���� �Ϸ�!");
		
		}catch(ClassNotFoundException e) {
			e.printStackTrace(); // OracleDriverŬ������ ������ �߻�
		}catch(SQLException e) {
			e.printStackTrace(); // Ŀ�ؼ�(DB�� ����)�ϴ� �������� ���� �߻�
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
