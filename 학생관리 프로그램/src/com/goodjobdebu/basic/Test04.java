package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class Test04 {
	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		Connection connection =null;
		PreparedStatement ps = null;
		Scanner scan = new Scanner(System.in);
		String name = null;
		String mail = null;
		//�Է¹� �غ�
		 System.out.println("�̸��� �Է��ϼ���.");
		 name=scan.nextLine();
		 System.out.println("������ �Է��ϼ���.");
		 mail=scan.nextLine();
		 
		 //���� �ۼ�
		String sql = 
		"insert into employee values('"+name+"','"+mail+"',1000,acc_seq.nextval,SYSDATE)";
		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		 

		
		 //����
			 ps = connection.prepareStatement(sql);
			 ps.execute();//�������Է��Ҷ�  commit�� �ڵ����� ������ �ȴ�.


		 
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
