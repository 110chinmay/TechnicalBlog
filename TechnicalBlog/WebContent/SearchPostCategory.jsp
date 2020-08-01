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

<!-- Latest compiled and minified CSS for bootstrap select-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">

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

	
	<div class="container mt-5">
	<div class="row">
		<div class="col-md-2 text-center">
			<label class="text-dark font-weight-bold">Select Category</label>
		</div>
		<div class="col-md-9 text-center">
		<select name="selValue" id="searchSel" multiple
			data-style=" bg-dark text-white rounded-pill px-4 py-3 shadow-sm "
			class="selectpicker w-100">
		</select>
		</div>
		<div class="col-md-1 text-center">
			<button class="btn btn-primary" onClick="searchCatVal()">Search</button>
		</div>
	</div>
	<div id="cardContainer" style="margin-top: 25px;"></div>
	</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
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

<!-- Latest compiled and minified JavaScript for bootstrap select-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>

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
				
				
				 var CategoryOpt = "ReadCat";
				var navData = {
					"CategoryOpt" : CategoryOpt
				}
				
				/* Populating the dropdown menu */
				$.ajax({
					url : "AddCategory",
					datatype : "json",
					type : "POST",
					data : navData,
					success : function(navData) {
						var json = jQuery.parseJSON(navData);
						
						$.each(json, function(k, v) {
							$("#searchSel").selectpicker();
							  $('#searchSel').append(
							'<option class="bg-dark text-white" value=' + v.CatId + '>'+ v.CategoryName + '</option>');
						    $("#searchSel").selectpicker("refresh");
						});
					},
					error : function(navData) {
						console.log(data + "in Error");
					}
				});
				
		/* Load the selected value in the url search */
				var params = window.location.search.split(/\?|\&/);
				var CategoryOpt = "SearchCat";
				var CatId = [params[1].split('=').pop()];
				
				
	
				var data = {
						"CategoryOpt":CategoryOpt,
						"CatId":CatId
				}
				console.log(data);
				
				$.ajax({
					url:"AddCategory",
					data:data,
					datatype:"JSON",
					type:"POST",
					success:function(data){
						$('select[name=selValue]').val(CatId);
						$('.selectpicker').selectpicker('refresh');
						var json = JSON.parse(data);
						
						var myHtml = "";
						$.each(json , function (key,value){
							
	myHtml += "<div class='card mb-3'> <img class='card-img-top' src=pics/"+value.postImage +" alt='Card image cap'> <div id='cardBody' class='card-body'><h5 class='card-title'>" + value.postTitle + "</h5><p class='card-text'>"+ value.postDesc +"</p><p id='cardText' class='card-text'><small class='text-muted'>"+ value.CategoryName +"</small></div></div>";
						});	
						$( "#cardContainer" ).html( myHtml );
					},
					error:function(data){
						alert("error"+data);
					}
				})
				
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
		
		function searchCatVal(){

			if ($('#searchSel').val() !=""){
				
				var CategoryOpt = "SearchCat";
				var CatId = $('#searchSel').val();
				
				var data = {
						"CategoryOpt":CategoryOpt,
						"CatId":CatId
				}
				
				console.log(data);
				
				$.ajax({
					url:"AddCategory",
					data:data,
					datatype:"JSON",
					type:"POST",
					success:function(data){
						var json = JSON.parse(data);
						var myHtml = "";
						$.each(json , function (key,value){
							
	myHtml += "<div class='card mb-3'> <img class='card-img-top' src=pics/"+value.postImage +" alt='Card image cap'> <div id='cardBody' class='card-body'><h5 class='card-title'>" + value.postTitle + "</h5><p class='card-text'>"+ value.postDesc +"</p><p id='cardText' class='card-text'><small class='text-muted'>"+ value.CategoryName +"</small></div></div>";
		
						});
								
						$( "#cardContainer" ).html( myHtml );
					},
					error:function(){}
					
				})
			} else {
				alert("Please select category");
			}
		}
		
		
	</script>
	</body>
</html>