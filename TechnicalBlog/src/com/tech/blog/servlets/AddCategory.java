package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.tech.blog.dao.CategoryDao;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Categories;
import com.tech.blog.entities.Post;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class AddCategory
 */
@WebServlet("/AddCategory")
public class AddCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCategory() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		PrintWriter out = response.getWriter();

		if (request.getParameter("CategoryOpt").equals("CreateCat")) {
			System.out.println(" in add category servlet");
			String CategoryName = request.getParameter("CategoryName");
			String CategoryDesc = request.getParameter("CategoryDesc");

			CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
			Boolean saveRes = catDao.saveCategory(new Categories(CategoryName, CategoryDesc));

			if (saveRes == true) {
				Gson gs = new Gson();
				out.print(saveRes);
			} else {
				out.print(false);
			}
		} else if (request.getParameter("CategoryOpt").equals("ReadCat")) {
			CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());

			List<Categories> JsonRes = dao.getAllCat();

			if (JsonRes != null) {

				Gson gs = new Gson();
				out.print(gs.toJson(JsonRes));

			} else {
				out.print("null");
			}
		} else if (request.getParameter("CategoryOpt").equals("UpdateCat")) {
			System.out.println(" Test Param UpdateCat");

			int CatId = Integer.parseInt(request.getParameter("CatId"));
			String CategoryName = request.getParameter("CategoryName");
			String CategoryDesc = request.getParameter("CategoryDesc");

			CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());
			Boolean UpdateRes = dao.UpdateCat(new Categories(CatId, CategoryName, CategoryDesc));
			if (UpdateRes == true) {
				Gson gs = new Gson();
				System.out.println(gs.toJson(UpdateRes));
				out.print(gs.toJson(UpdateRes));
				gs.toJson(UpdateRes);
			} else {
				out.print("null");
			}
		} else if (request.getParameter("CategoryOpt").equals("DeleteCat")) {
			int CatId = Integer.parseInt(request.getParameter("CatId"));
			CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());
			Boolean DeleteRes = dao.DeleteCat(CatId);
			if (DeleteRes == true) {
				Gson gs = new Gson();
				out.print(gs.toJson(DeleteRes));
				gs.toJson(DeleteRes);
			} else {
				out.print("null");
			}
		} else if (request.getParameter("CategoryOpt").equals("SearchCat")) {
			System.out.println("In search Cat");

			String[] dataArr = request.getParameterValues("CatId[]");

			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			List<Post> SearchPostRes = dao.searchPostCat(dataArr);

			if (SearchPostRes != null) {
				Gson gs = new Gson();
				out.print(gs.toJson(SearchPostRes));
				System.out.println(gs.toJson(SearchPostRes));
			} else {
				out.print("Something went Wrong");
			}

		}
	}
}
