package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Post;

public class PostDao {

	private Connection con;

	public PostDao(Connection con) {

		this.con = con;
	}

	public Boolean savePost(Post post) {
		boolean postSaveRes = false;

		String query = "insert into post(postTitle,postDesc,catId,postImage) values (?,?,?,?)";

		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, post.getPostTitle());
			pstmt.setString(2, post.getPostDesc());
			pstmt.setInt(3, post.getCatId());
			pstmt.setString(4, post.getPostImage());
			pstmt.execute();
			postSaveRes = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return postSaveRes;
	}

	public List<Post> readPost() {

		String query = "select postId,postTitle,postDesc,postImage,CategoryName from post pst, categories cat where pst.catId = cat.catId order by postId desc;";

		List<Post> postList = new ArrayList<>();

		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Post pst = new Post();
				pst.setPostId((rs.getInt("postId")));
				pst.setPostTitle(rs.getString("postTitle"));
				pst.setPostDesc(rs.getString("postDesc"));
				pst.setPostImage(rs.getString("postImage"));
				pst.setCategoryName(rs.getString("CategoryName"));

				postList.add(pst);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return postList;

	}

	public List<Post> searchPostCat(String[] dataArr) {

		String query = "select * from post pst, categories cat where pst.catId = cat.catId and pst.catId in (?) ";
		ResultSet rs = null;
		List<Post> SearchpostList = new ArrayList<>();
		try {
			PreparedStatement pstmt = con.prepareStatement(query);

			for (String CatId : dataArr) {
				pstmt.setString(1, CatId);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					Post pst = new Post();
					pst.setCatId(rs.getInt("postId"));
					pst.setPostTitle(rs.getString("postTitle"));
					pst.setPostDesc(rs.getString("postDesc"));
					pst.setPostImage(rs.getString("postImage"));
					pst.setCategoryName(rs.getString("CategoryName"));
					SearchpostList.add(pst);
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return SearchpostList;
	}

}
