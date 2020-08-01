package com.tech.blog.entities;

public class Post {

	private int postId;
	private String postTitle;
	private String postDesc;
	private int catId;
	private String postImage;
	private String CategoryName;

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	public Post(String postTitle, String postDesc, int catId, String postImage) {
		this.postTitle = postTitle;
		this.postDesc = postDesc;
		this.catId = catId;
		this.postImage = postImage;
	}

	public Post() {
		// TODO Auto-generated constructor stub
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostDesc() {
		return postDesc;
	}

	public void setPostDesc(String postDesc) {
		this.postDesc = postDesc;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public String getPostImage() {
		return postImage;
	}

	public void setPostImage(String postImage) {
		this.postImage = postImage;
	}

}
