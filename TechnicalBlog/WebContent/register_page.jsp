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
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 70% 100%, 30% 100%, 0 87%, 0 0
		);
}
</style>
<title>Register Form</title>
</head>
<body onload="checkLogin()">

	<!-- Navbar include Dir -->
	<%@include file="normal_navbar.jsp"%>

	<main class="primary-background banner-background"
		style="padding-bottom:50px;">
	<div class="container">
		<div class="col-md-6 offset-md-3">
			<div class="card">
				<div class="card-header fa fa-user-circle">Registration Form</div>
				<div class="card-body">
					<form id="reg-form" action="RegisterServlet" method="POST">
						<div class="form-group">
							<label for="user_name">Username</label> <input type="text"
								class="form-control" name="user_name" id="user_name"
								placeholder="Username">
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="inputEmail4">Email</label> <input type="email"
									class="form-control" name="user_email" id="inputEmail4"
									placeholder="Email">
							</div>
							<div class="form-group col-md-6">
								<label for="inputPassword4">Password</label> <input
									type="password" class="form-control" id="inputPassword4"
									placeholder="Password" name="user_password">
							</div>
						</div>
						<div class="form-group">
							<label for="about">About</label>
							<textarea class="form-control" id="about" name="user_about"
								rows="3" placeholder="Entersome thing about youself"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="gender">Select Gender</label><br> <input
									type="radio" id="gender" name="gender" value="Male">
								Male <input type="radio" id="gender" name="gender"
									value="female"> Female
							</div>
							<div class="form-group col-md-6">
								<div class="form-check">
									<input name="check" class="form-check-input" type="checkbox"
										id="gridCheck"> <label class="form-check-label"
										for="gridCheck"> Terms & Conditions</label>
								</div>
							</div>
						</div>
						<div class="container text-center" id="loader"
							style="display: none">
							<span class="fa fa-refresh fa-spin fa-3x"></span>
							<h4>Please Wait...</h4>
						</div>
						<button id="submit-btn" type="submit" class="btn btn-primary">
							Register</button>

					</form>
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
	
	
		$(document).ready(function() {
		

			$('#reg-form').on("submit", function(event) {

				event.preventDefault();
				let form = new FormData(this);
				
				$("#loader").show();
				$("#submit-btn").prop('disabled', true);
				
				
				
				/* Ajax call to servlet */

		$.ajax({

					url : "RegisterServlet",
					type : "POST",
					data : form,
					success : function(data, textStatus, jqXHR) {
						if(data){
							console.log(data);
							$("#loader").hide();
							$("#submit-btn").prop('disabled', true);
							swal("Registered Successfully..!", "Thanks :)")
							.then((value) => {
								window.location="login_page.jsp";
								});
						}else{
							$("#submit-btn").prop('disabled', false);
							$("#loader").hide();
							swal("Something went wrong..!", data,"error");
						}
						
					},
					error : function(jqXHR, textStatus, errorThrown) {
						swal("Something went wrong!!!");
						$("#loader").hide();
						$("#submit-btn").prop('disabled', false);
					},
					processData:false,
					contentType:false
				}); 
			})
		});
	</script>

	<!-- Sweet Alert CDN -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

	<!-- font-awesome src -->
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>



</body>
</html>