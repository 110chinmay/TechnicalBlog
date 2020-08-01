$(document).ready(function(){


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
							'<a class="dropdown-item" onclick="UserCategory(' + v.CatId + ')" value=' + v.CatId + '>'+ v.CategoryName + '</a>'); 
							
				});
			},
			error : function(navData) {
				console.log(data + "in Error");
			}
		}); 
	});

function UserCategory(CatId){
	
	window.location='SearchPostCategory.jsp?catId='+CatId+'';
	

}

