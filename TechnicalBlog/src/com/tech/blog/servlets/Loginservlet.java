package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.SessionHelper;

/**
 * Servlet implementation class Loginservlet
 */
@WebServlet("/Loginservlet")
public class Loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

		System.out.println("in Login servlet");
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");

		/* Creating all the required Tables */
		ConnectionProvider.CreateTable();

		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		User loginResponse = dao.validateUser(new User(userEmail, userPassword));

		if (loginResponse != null) {

			HttpSession session = request.getSession();
			SessionHelper sh = new SessionHelper(loginResponse, session);

			Gson gson = new Gson();
			// System.out.println((gson.toJson(sh)));

			PrintWriter out = response.getWriter();
			out.print(gson.toJson(sh));

		} else {
			System.out.println("Invalid User");
		}

	}

}
