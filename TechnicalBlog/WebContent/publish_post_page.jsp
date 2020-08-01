<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

.dropdown-menu {
	max-height: 7rem;
	overflow-y: auto;
}
</style>

<title>Tech Blog</title>
</head>
<body onload="checkLogin()">
	<!-- Navbar include Dir -->
	<%@include file="normal_navbar.jsp"%>

	<main class="d-flex primary-background banner-background">
	<div class="container mt-3 mb-3">
		<div class="col-md-3 offset-md-3">
			<div class="card" style="width: 35rem;">
				<div class="card-header">What's up today!!!</div>
				<div class="card-body">
					<form method="post" action="AddPost" enctype="multipart/form-data"
						id="fileUploadForm">
						<label >Title</label> <input type="text"
							class="form-control" name="postTitle" id="postTitle"
							aria-describedby="emailHelp" placeholder="Title"><br>
							<input type="text" name="postOpt" value="addPost"  hidden>
						<label>Contents</label>
						<textarea class="form-control" id="postDesc" rows="3"
							placeholder="Content" name="postDesc" required></textarea>
						<br>
						<div class="row">
							<div class="dropdown form-group col-md-6">
								<select class="form-control" name="postCat" id="postCat"
									class="btn btn-light">
								</select>
							</div>
							<div class="form-group col-md-6">
								<input type="file" class="form-control form-control-file"
									id="postImg" name="postImg">
							</div>
						</div>
						<br>

						<div class="container" style="text-align: center">
							<button type="submit" id="btnSubmit" class="btn btn-primary">Submit</button>
						</div>
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
				$("#publish_post_page").addClass('active');
				if ((sessionStorage.getItem("name") == "chinmay110")) {
					$("#addCat").show();
				}
			} else {
				$("#logout-val").hide();
			}

			var CategoryOpt = "ReadCat";
			var data = {
				"CategoryOpt" : CategoryOpt
			}

			$.ajax({
				url : "AddCategory",
				datatype : "json",
				type : "POST",
				data : data,
				success : function(data) {
					var json = jQuery.parseJSON(data);
					$.each(json, function(k, v) {
						//add the new option to the select box
						$('#postCat').append(
								'<option value=' + v.CatId + '>'
										+ v.CategoryName + '</option>');
					});
				},
				error : function(data) {
					console.log(data + "in Error");
				}
			});
		}

		$('#dropdown-menu li a').click(function() {
			alert();
			$('#selected').text($(this).text());
		});

	</script>

</body>
</html>