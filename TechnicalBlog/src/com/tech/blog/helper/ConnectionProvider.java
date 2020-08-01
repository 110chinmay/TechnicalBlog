package com.tech.blog.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ConnectionProvider {

	private static Connection con;

	public static Boolean CreateTable() {
		Boolean createRes = false;
		Connection con = getConnection();
		String CatSql = "CREATE TABLE IF NOT EXISTS categories (catId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,CategoryName VARCHAR(255) NOT NULL,CategoryDesc VARCHAR(255) NOT NULL)";
		String PostSql = "CREATE TABLE IF NOT EXISTS post (postId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,postTitle VARCHAR(1000) NOT NULL,postDesc VARCHAR(255) NOT NULL,catId INT(10) NOT NULL,postImage VARCHAR(1000) NOT NULL)";
		String UserSql = "CREATE TABLE IF NOT EXISTS user (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,name VARCHAR(500) NOT NULL,email VARCHAR(45) NOT NULL,password VARCHAR(45) NOT NULL,gender VARCHAR(45) NOT NULL,about VARCHAR(4000),regdate TIMESTAMP)";
		try {
			PreparedStatement pstmt1 = con.prepareStatement(CatSql);
			pstmt1.executeUpdate();
			PreparedStatement pstmt2 = con.prepareStatement(PostSql);
			pstmt2.executeUpdate();
			PreparedStatement pstmt3 = con.prepareStatement(UserSql);
			pstmt3.executeUpdate();
			createRes = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return createRes;

	}

	public static Connection getConnection() {
		if (con == null) {
			try {

				/* Driver load class */
				Class.forName("com.mysql.jdbc.Driver");

				/* Create Connection */
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "root");

			} catch (Exception e) {

				e.printStackTrace();
			}
		}
		return con;
	}

}
