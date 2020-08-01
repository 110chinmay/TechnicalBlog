package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tech.blog.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	public Boolean saveUser(User user) {

		Boolean f = false;
		try {
			String query = "insert into user(name,email,password,gender,about) values (?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public User validateUser(User user) {

		try {
			String query = "select name,email FROM user where email = ? and password = ? ";
			PreparedStatement stmt = this.con.prepareStatement(query);

			stmt.setString(1, user.getEmail());
			stmt.setString(2, user.getPassword());

			ResultSet result = stmt.executeQuery();
			user = null;
			if (result.next()) {
				user = new User();
				user.setName(result.getString("name"));
				user.setEmail(result.getString("email"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

}
