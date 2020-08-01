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
	<%@include file="normal_navbar.jsp"%>

	<div class="container">
		<div class="row text-align-center">
			<table id="myTable" class="table">
				<thead class="thead-dark">
					<tr>
						
						<th style="text-align: center;" scope="col">Category Name</th>
						<th style="text-align: center;" scope="col">Category Description</th>
						<th style="text-align: center;" scope="col">Update Category</th>
						<th style="text-align: center;" scope="col">Delete Category</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<!-- Modal -->
			<div class="modal fade" id="updateCatModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Update Category</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        	<div class="container">
			        <div class="form-group">
						<label>Category Name</label> 
						<input hidden type="text"
							class="form-control" id="CatId"
							placeholder="Enter Category">
						<input type="text"
							class="form-control" id="CategoryName"
							placeholder="Enter Category" required>
					</div>
					<div class="form-group">
						<label>Category Desc</label>
						<textarea class="form-control" id="CategoryDesc" rows="3"
							placeholder="Enter Category Desc." required></textarea>
					</div>
				</div>
			   </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button id='UpdateCat' onClick="UpdateCat()" class="btn btn-primary">Save changes</button>
			      </div>
			    </div>
			  </div>
			</div>
	</div>
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
	var json = '';
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

							 json = jQuery.parseJSON(data);
							$.each(json,function(k, v) {
								
								$('#myTable tr:last').after('<tr><td style="text-align: center;" id="CatName">'+v.CategoryName+'</td></tr>');
								$('#myTable td:last').after('<td style="text-align: center;" id="CatDesc">'+v.CategoryDesc+'</td>');;
								$('#myTable td:last').after('<td style="text-align: center;"><div onclick=UpdateCatmodal('+v.CatId+') data-toggle="modal" data-target="#updateCatModel" class="fa fa-pencil-square-o"></div></td>');
								$('#myTable td:last').after('<td style="text-align: center;"><span class="fa fa-trash" onclick=DeleteCatmodal('+v.CatId+')></span></td>');	
							});
						},
						error : function(data) {
							console.log(data + "in Error");
						}
					});
		}
		
		function UpdateCatmodal(UpdateCatId){
			for ( i=0; i < json.length ; i++)
				if((json[i].CatId) == UpdateCatId){
					console.log(json[i].CatId);
					$('#CatId').val(json[i].CatId);
					$('#CategoryName').val(json[i].CategoryName);
					$('#CategoryDesc').val(json[i].CategoryDesc);
				}
		}
		
		function UpdateCat(){
			var CatId = $('#CatId').val();
			var CategoryName = $('#CategoryName').val();
			var CategoryDesc = $('#CategoryDesc').val();
			var CategoryOpt = 'UpdateCat';
			
			var data = {"CategoryOpt" : CategoryOpt,"CatId":CatId,"CategoryName":CategoryName,"CategoryDesc":CategoryDesc};
			
			$.ajax({
				url:"AddCategory",
				datatype:"json",
				type:"POST",
				data : data,
				success : function(data) {
					console.log(data);
					$('#updateCatModel').modal('hide');
					location.reload();
				},
				error : function (data){
					alert("Something went wrong"+data);
				}
			})
			
		}
		
		function DeleteCatmodal(CatId){
			swal({
				  title: "Are you sure?",
				  text: "Once deleted, you will not be able to recover!",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				}).then((willDelete) => {if (willDelete) {
					var CategoryOpt = 'DeleteCat';
						
					var data = {"CategoryOpt" : CategoryOpt,"CatId":CatId};
						
						$.ajax({
							url:"AddCategory",
							datatype:"json",
							type:"POST",
							data : data,
							success : function(data) {
								swal("Poof! Your imaginary file has been deleted!", {
								    icon: "success",
								    });
								console.log(data);
								location.reload();
							},
							error : function (data){
								alert("Something went wrong"+JSON.stringify(data));
							}
						})
				  }
				});
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