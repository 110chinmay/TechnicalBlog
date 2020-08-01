package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@MultipartConfig
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
		doGet(request, response);

		String check = request.getParameter("check");
		String name = request.getParameter("user_name");
		String email = request.getParameter("user_email");
		String password = request.getParameter("user_password");
		String about = request.getParameter("user_about");
		String gender = request.getParameter("gender");

		if (name == null || name.isEmpty()) {
			PrintWriter out = response.getWriter();
			out.println(" Username cannot be blank");
		} else if (email == null || email.isEmpty()) {
			PrintWriter out = response.getWriter();
			out.println(" Email cannot be blank");
		} else if (password == null || password.isEmpty()) {
			PrintWriter out = response.getWriter();
			out.println(" Password cannot be blank");
		} else if (gender == null || gender.isEmpty()) {
			PrintWriter out = response.getWriter();
			out.println(" Gender cannot be blank");
		} else if (check == null) {
			PrintWriter out = response.getWriter();
			out.println(" Terms & Conditions Box not checked");
		} else {

			/* Creating UserDao object */
			ConnectionProvider.CreateTable();
			UserDao usrdao = new UserDao(ConnectionProvider.getConnection());
			boolean usr = usrdao.saveUser(new User(name, email, password, gender, about, null));
			if (usr == true) {
				PrintWriter out = response.getWriter();
				out.print(" Data is saved successfully");
			} else {
				PrintWriter out = response.getWriter();
				out.print(" Something went wrong!");
			}
		}

	}

}
