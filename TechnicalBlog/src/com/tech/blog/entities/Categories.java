package com.tech.blog.entities;

public class Categories {

	private int CatId;
	private String CategoryName;
	private String CategoryDesc;

	public Categories() {

	}

	public Categories(String categoryName, String categoryDesc) {
		CategoryName = categoryName;
		CategoryDesc = categoryDesc;
	}

	public Categories(int catId, String categoryName, String categoryDesc) {
		CatId = catId;
		CategoryName = categoryName;
		CategoryDesc = categoryDesc;
	}

	public int getCatId() {
		return CatId;
	}

	public void setCatId(int catId) {
		CatId = catId;
	}

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	public String getCategoryDesc() {
		return CategoryDesc;
	}

	public void setCategoryDesc(String categoryDesc) {
		CategoryDesc = categoryDesc;
	}

}
