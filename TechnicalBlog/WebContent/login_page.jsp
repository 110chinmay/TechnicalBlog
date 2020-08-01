<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 70% 100%, 30% 100%, 0 87%, 0 0);
}
</style>
<title>Login page</title>
</head>
<body onload="checkValidUser()">

<!-- Navbar include Dir -->
<%@include file="normal_navbar.jsp"  %>
	
	
	<main class="d-flex align-items-center primary-background banner-background" style="height:60vh" >
	<div class="container mb-4">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-header"><span class="fa fa-user"></span> Login</div>
					<div class="card-body">
						
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="userEmail"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="userPassword"
									placeholder="Password">
							</div>
							<br>
							<button  onclick="checkLogin()" class="btn btn-primary">Submit</button>
					
					</div>
				</div>
			</div>
		</div>

	</div>
	</main>


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
	
	<!-- Javascript login page -->
	<script>
		
		function checkLogin(){
			var userEmail = $("#userEmail").val();
			var userPassword = $("#userPassword").val();
			
			var data ={
					'userEmail' : userEmail,
					'userPassword' : userPassword
			};
			
			$.ajax({
				url: "Loginservlet",
				type:"POST",
				dataType: "json",
				data: data,
				success: function(data){
					var json = JSON.parse(JSON.stringify(data));
					sessionStorage.setItem("name", json.user.name);
					sessionStorage.setItem("email", json.user.email);
					sessionStorage.setItem("sessionId", json.session.session.id); 
					window.location="index.jsp";
				},
				error : function (data){
					var json = JSON.stringify(data);
					console.log("Error Function "+data);
					alert("invalid useremail or password");
				}
			});
		}
		
		
		function checkValidUser() {
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
				
				
				var CategoryOpt = "ReadCat";
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
									'<a class="dropdown-item" href="#" value=' + v.CatId + '>'+ v.CategoryName + '</a>'); 
									
						});
					},
					error : function(navData) {
						console.log(data + "in Error");
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
	
	</script>

</body>
</html>