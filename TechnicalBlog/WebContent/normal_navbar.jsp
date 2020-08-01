<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   </head>
   <body onload="checkLogindata()">
      <nav class="navbar navbar-expand-lg navbar-dark primary-background">
         <a class="navbar-brand" href="index.jsp"><span
            class="fas fa-laptop"></span> Tech Blog</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
               <li id="Home-icon" class="nav-item"><a class="nav-link" href="index.jsp"><span
                  class="fa fa-home"></span> Home <span class="sr-only">(current)</span>
                  </a>
               </li>
               <li class="nav-item dropdown">
                  <a
                     class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                     role="button" data-toggle="dropdown" aria-haspopup="true"
                     aria-expanded="false"><span class="fa fa-folder"></span>
                  Categories </a>
                  <div id="navCat" class="dropdown-menu" aria-labelledby="navbarDropdown">
                     <!-- <a class="dropdown-item" href="#">Programming Language</a> 
                     <a class="dropdown-item" href="#">Project Impl</a>
                     <a class="dropdown-item" href="#">Data Structure</a> -->
                  </div>
               </li>
                <li class="nav-item dropdown" id="addCat" style="display: none;">
                  <a
                     class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                     role="button" data-toggle="dropdown" aria-haspopup="true"
                     aria-expanded="false"><span class="fa fa-tasks"></span> Categories details</a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                     <a class="dropdown-item" href="categories_add.jsp">Add Categories</a> <a
                        class="dropdown-item" href="view_category.jsp">View Categories Details</a>
                  </div>
               </li>
               <li class="nav-item"><a class="nav-link" href="#"><span
                  class="fa fa-area-chart"></span> Contact</a></li>
               <li id="Login-li" class="nav-item"><a class="nav-link"
                  href="login_page.jsp"><span class="fa fa-user"></span> Login</a></li>
               <li id="reg-li" class="nav-item"><a class="nav-link"
                  href="register_page.jsp"><span class="fa fa-address-card"></span>
                  User Register</a>
               </li>
               <li style="display:none" id="publish_post_page" class="nav-item"><a class="nav-link"
                  href="publish_post_page.jsp"><span class="fa fa-plus"></span>Add post</a></li>
            </ul>
           <ul class="navbar-nav mr-right">
           <li class="nav-item">
           			<a class="nav-link"><span id="setUser" class="fa fa-user-circle text-white"></span></a>
           		</li>
           		<li class="nav-item">
           			<a class="nav-link" id="logout-val" onClick="Logout();"><span style="cursor:pointer" class="fa fa-user-plus text-white">Logout</span></a>
           		</li>
           		
           </ul>
         </div>
      </nav>
      <script src="https://code.jquery.com/jquery-3.5.1.min.js"
         integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
         crossorigin="anonymous"></script>
   </body>
</html>