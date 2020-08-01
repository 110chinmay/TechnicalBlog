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
</head>
<body onload="checkLogin()">
	<!-- Navbar include Dir -->
	<%@include file="normal_navbar.jsp"%>
	<main class=" d-flex primary-background banner-background">
	<div class="container">
		<div class="row justify-content-center mt-1 mb-3">
			<div class="card" style="width: 18rem;">
				<div class="card-header">Category Details</div>
				<div class="card-body">
					<div class="form-group">
						<label>Category Name</label> <input type="text"
							class="form-control" id="CategoryName"
							placeholder="Enter Category" required>
					</div>
					<div class="form-group">
						<label>Category Desc</label>
						<textarea class="form-control" id="CategoryDesc" rows="3"
							placeholder="Enter Category Desc." required></textarea>
					</div>
					<button onClick="catSubmit()" class="btn btn-primary">Submit</button>
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

	<script>
		function checkLogin() {
			if ((sessionStorage.getItem("name") != '')
					&& (sessionStorage.getItem("name") != null)) {
				$("#login-btn").hide();
				$("#Login-li").hide();
				$("#reg-li").hide();
				$("#setUser").text(sessionStorage.getItem("name"));
				$("#logout-val").show();
				$("#addCat").addClass('active');
				if ((sessionStorage.getItem("name") == "chinmay110")) {
					$("#addCat").show();
				}
			} else {
				$("#logout-val").hide();
			}
		}

		function Logout() {
			sessionStorage.removeItem("name");
			sessionStorage.removeItem("email");
			sessionStorage.removeItem("sessionId");
			window.location = "index.jsp";
		}
		
		function catSubmit(){
			var CategoryOpt = "CreateCat";
			var CategoryName = $("#CategoryName").val();
			var CategoryDesc = $("#CategoryDesc").val();
			
			var data = {"CategoryOpt":CategoryOpt,"CategoryName":CategoryName,"CategoryDesc":CategoryDesc}
			
			$.ajax({
				url:"AddCategory",
				datatype:"json",
				type:"POST",
				data: data,
				success: function(data){
					window.location= "view_category.jsp"
				},
				error:function (data){
					console.log(data+"in Error");
				}
			});
		}
	</script>
</body>
</html>