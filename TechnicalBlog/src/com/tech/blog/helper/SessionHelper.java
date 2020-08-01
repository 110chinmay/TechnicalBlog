package com.tech.blog.helper;

import javax.servlet.http.HttpSession;

import com.tech.blog.entities.User;

public class SessionHelper {

	User user;
	HttpSession session;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public SessionHelper(User user, HttpSession session) {
		this.user = user;
		this.session = session;
	}

}
