<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<title>HOME DECORS</title>

</head>
<body background="https://www.walldevil.com/wallpapers/a57/wallpaper-mac-desktop-logo-apple-brand-company.jpg" background-size:100% ;">
<jsp:include page="header.jsp"></jsp:include>
<div class="container" >
 <div id="myCarousel" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
   <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1" ></li>
    <li data-target="#myCarousel" data-slide-to="2" ></li>
   </ol>
 <div class="carousel-inner">
  <div class="item active">
    <img class="img-rounded"class="image-responsive center block" src="https://images.unsplash.com/photo-1497215842964-222b430dc094?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=48fe9f87e4a3344a46e80ddf5c3bdfa6&auto=format&fit=crop&w=1050&q=80"  style="width:100%"/>
  </div>
   <div class="item">
    <img class ="img-rounded"class="image-responsive center block"src="https://images.unsplash.com/photo-1509741102003-ca64bfe5f069?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=70fc6ad5bb20c3c6d9be87d13628bc8b&auto=format&fit=crop&w=1050&q=80" style="width:100%;hight:100%"/>
  </div>
  <div class="item">
    <img class ="img-rounded"class="image-responsive center block" src="https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=297896f3df72b2721f7c274f0688c04f&auto=format&fit=crop&w=1951&q=80" style="width:100%"/>
   </div>
   <div class="item">
    <img class ="img-rounded"class="image-responsive center block"src=https://images.unsplash.com/5/unsplash-kitsune-3.jpg?ixlib=rb-0.3.5&s=f1e6a8f83c1fa922db6d9d427ede91b3&auto=format&fit=crop&w=1950&q=80 style="width:100%;hight:100%"/>
  </div>
</div>
<a class="left carousel-control" href="#myCarousel"data-slide="prev">
<span class="glyphicon glyphicon-chevron-left"></span>
<span class="sr-only">Previous</span>
</a>

<a class="right carousel-control" href="#myCarousel"data-slide="next">
<span class="glyphicon glyphicon-chevron-right"></span>
<span class="sr-only">Next</span>
</a>
</div>
</div>
<div>
<body>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</div>

	
 </body>
</html>


