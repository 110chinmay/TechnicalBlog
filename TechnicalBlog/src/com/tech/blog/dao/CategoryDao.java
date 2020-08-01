package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Categories;

public class CategoryDao {

	private Connection con;

	public CategoryDao(Connection con) {
		this.con = con;
	}

	public boolean saveCategory(Categories cat) {
		boolean saveRes = false;

		String query = "Insert into categories (CategoryName, CategoryDesc ) values (?,?)";

		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, cat.getCategoryName());
			pstmt.setString(2, cat.getCategoryDesc());
			pstmt.executeUpdate();
			saveRes = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return saveRes;
	}

	public List<Categories> getAllCat() {

		System.out.println("In all getAll Cat");

		List<Categories> categorys = new ArrayList<Categories>();

		String query = "select * from categories";
		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Categories category = new Categories();
				category.setCatId(rs.getInt("catId"));
				category.setCategoryName(rs.getString("CategoryName"));
				category.setCategoryDesc(rs.getString("CategoryDesc"));
				categorys.add(category);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return categorys;
	}

	public Boolean UpdateCat(Categories categories) {
		Boolean UpdateRes = false;
		String Query = "update categories set CategoryName= ? ,CategoryDesc=? where catId= ?";
		try {
			PreparedStatement pstmt = this.con.prepareStatement(Query);
			pstmt.setString(1, categories.getCategoryName());
			pstmt.setString(2, categories.getCategoryDesc());
			pstmt.setInt(3, categories.getCatId());

			pstmt.executeUpdate();
			UpdateRes = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return UpdateRes;
	}

	public Boolean DeleteCat(int CatId) {
		Boolean DeleteRes = false;
		System.out.println("In the DeleteCat Dao");
		String Query = "Delete from categories where CatId = ?";

		try {
			PreparedStatement pstmt = this.con.prepareStatement(Query);
			pstmt.setInt(1, CatId);
			pstmt.execute();
			DeleteRes = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return DeleteRes;
	}
}
