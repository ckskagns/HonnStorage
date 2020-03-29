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
		"insert into employee(name ,mail ,money ,num  ,insert_date)values('������','fwqw@.com',200,acc_seq.nextval,'2020-03-29')",
		"insert into employee(name ,mail ,money ,num  ,insert_date)values('���ϱ�','avbqw@.com',300,acc_seq.nextval,'2020-03-29')",
		"insert into employee(name ,mail ,money ,num  ,insert_date)values('������','qww@.com',400,acc_seq.nextval,'2020-03-29')"
		};
		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		
		 for (int i = 0; i < 3; i++) {
			 
			 ps = connection.prepareStatement(sql[i]);
			 ps.execute();//�������Է��Ҷ�  commit�� �ڵ����� ������ �ȴ�.
		 }


		 
		System.out.println("������ �Է� �Ϸ�!");
		
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
