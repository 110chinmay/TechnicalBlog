<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<!-- Application CSS -->
<link href="css/myStyle.css" rel="stylesheet" type="text/css" />

<!-- font Awesome link -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 70% 100%, 30% 100%, 0 87%, 0 0
		);
}
img {
  width: 100%;
  height: auto;
  object-fit: cover;
}
</style>

<title>Tech Blog</title>
</head>
<body onload="checkLogin()">
	<!-- Navbar include Dir -->
	<%@include file="normal_navbar.jsp"%>

	<div class="container-fluid m-0 p-0">
		<div class="jumbotron primary-background text-white banner-background">
			<div class="container">
				<h3 class="display-3">Welcome to Tech Blog</h3>
				<p>Coverage includes computer hardware, software, mobile apps
					and devices, personal technology, cybersecurity and emerging tech
					for businesses.</p>
				<a href="login_page.jsp" id="login-btn"
					class="btn btn-outline-light"> <span class="fa fa-user-circle"></span>
					Login
				</a> <a href="publish_post_page.jsp" id="post-btn"
					class="btn btn-outline-light"> <span class="fa fa-plus"></span>
					Post
				</a>
			</div>
		</div>
		<div id="cardContainer" class="container">
			<!-- <div class="card mb-3"> 
				<img class="card-img-top" src="..." alt="Card image cap">
				<div id="cardBody" class="card-body">
				<h5 class='card-title'></h5>
				<p class='card-text'></p>
					<p id="cardText" class="card-text">
						
					</p>
				</div>
			</div> -->
		</div>
	</div>




	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

	<!-- inbuild javascript script -->
	 <script src="js/myjs.js" type="text/javascript"></script> 

	<!-- font-awesome src -->
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>

	<script>
		function checkLogin() {
			if ((sessionStorage.getItem("name") != '')
					&& (sessionStorage.getItem("name") != null)) {
				$("#login-btn").hide();
				$("#Login-li").hide();
				$("#reg-li").hide();
				$("#setUser").text(sessionStorage.getItem("name"));
				$("#logout-val").show();
				$("#publish_post_page").show();
				$("#post-btn").show();
				$("#Home-icon").addClass('active');
				
				
				/* var CategoryOpt = "ReadCat";
				var navData = {
					"CategoryOpt" : CategoryOpt
				}
				
				$.ajax({
					url : "AddCategory",
					datatype : "json",
					type : "POST",
					data : navData,
					success : function(navData) {
						var json = jQuery.parseJSON(navData);
						$.each(json, function(k, v) {
							$('#navCat').append(
									'<a class="dropdown-item" onclick="UserCategory(' + v.CatId + ')" value=' + v.CatId + '>'+ v.CategoryName + '</a>'); 
									
						});
					},
					error : function(navData) {
						console.log(data + "in Error");
					}
				});  */
						
				var postOpt = "readPost";
				var data={"postOpt": postOpt};
				
				$.ajax({
					url:"AddPost",
					datatype:"json",
					data:data,
					type:"POST",
					success : function (data){
						var parseJson = JSON.parse(data);
						var myHtml = "";
						$.each(parseJson , function (key,value){
							
	myHtml += "<div class='card mb-3'> <img class='card-img-top' src=pics/"+value.postImage +" alt='Card image cap'> <div id='cardBody' class='card-body'><h5 class='card-title'>" + value.postTitle + "</h5><p class='card-text'>"+ value.postDesc +"</p><p id='cardText' class='card-text'><small class='text-muted'>"+ value.CategoryName +"</small></div></div>";
		
						});
								
						$( "#cardContainer" ).html( myHtml );
						/* console.log(parseJson);
						console.log("success"); */
					}, 
					error : function (data){
						alert("Something Went Wrong"+Error);
					}
					
				});
				
				
			if ((sessionStorage.getItem("name") == "chinmay110")) {
					$("#addCat").show();
				}
			} else {
				$("#logout-val").hide();
				$("#post-btn").hide();
			}
			
			
		}

		function Logout() {
			sessionStorage.removeItem("name");
			sessionStorage.removeItem("email");
			sessionStorage.removeItem("sessionId");
			window.location = "index.jsp";
		}
	</script>


</body>
</html>