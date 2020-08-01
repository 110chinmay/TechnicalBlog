package com.tech.blog.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class AddPost
 */
@WebServlet("/AddPost")
@MultipartConfig
public class AddPost extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("In the add post servlet");

		PrintWriter out = response.getWriter();

		if (request.getParameter("postOpt").equals("addPost")) {
			InputStream inputStream = null;
			String postImgName = null;

			// Other Paramaters
			int catId = Integer.parseInt(request.getParameter("postCat"));
			String postTitle = request.getParameter("postTitle");
			String postDesc = request.getParameter("postDesc");

			// obtains the upload file part in this multipart request
			Part filePart = request.getPart("postImg");

			if (filePart != null) {
				// debug messages

				postImgName = filePart.getSubmittedFileName();

				PostDao dao = new PostDao(ConnectionProvider.getConnection());
				Boolean postSaveRes = dao.savePost(new Post(postTitle, postDesc, catId, postImgName));

				if (postSaveRes == true) {

					InputStream is = filePart.getInputStream();

					byte[] data = new byte[is.available()];

					is.read(data);

					String path = request.getRealPath("/") + "pics" + File.separator + postImgName;

					FileOutputStream fos = new FileOutputStream(path);
					fos.write(data);
					fos.close();

					response.sendRedirect("index.jsp");
				} else {
					out.print("Something Went wrong");
				}
			}
		} else if (request.getParameter("postOpt").equals("readPost")) {

			System.out.println("in the readPost");

			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			List<Post> readRes = dao.readPost();

			if (readRes != null) {
				Gson gs = new Gson();
				out.print(gs.toJson(readRes));
			} else {
				out.print("something went wrong!");
			}
		}

	}

}
