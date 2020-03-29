package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class Test05 {
	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		Connection connection =null;
		PreparedStatement ps = null;

		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		 
		 // Employee���̺� �Է¹��� �л� �̸�, ����ó�� ���ڵ�� �߰��غ���.
		 Scanner sc = new Scanner(System.in);
		 String name;
		 String tel;
		 System.out.print("�л��̸� : ");
		 name = sc.next();
		 System.out.println("�л� ����ó : ");
		 tel = sc.next();
		 
		 int kr,en,ma;
		 double avg;
		 
		 System.out.print("���� : ");
		 kr = sc.nextInt();
		 System.out.print("���� : ");
		 en = sc.nextInt();
		 System.out.print("���� : ");
		 ma = sc.nextInt();		
		
		 avg = (kr+en+ma)/3.0;		 
		 
		 String sql = "INSERT INTO student values(student_seq.NEXTVAL,?,?,?,?,?,?,SYSDATE)";
		 ps = connection.prepareStatement(sql);
		 ps.setString(1, name);
		 ps.setString(2, tel);
		 ps.setInt(3, kr);
		 ps.setInt(4, en);
		 ps.setInt(5, ma);
		 ps.setDouble(6, avg);
		 ps.execute();
		 System.out.println("�л��߰��Ϸ�");


		
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
