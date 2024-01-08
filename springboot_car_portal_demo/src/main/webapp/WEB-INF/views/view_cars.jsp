<%@ page contentType="text/html; charset=US-ASCII"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<style>
        body {
            background: linear-gradient(to top, #FFFFFF, #e6ccff);
        }
    </style>
<!--  Enable Bootstrap -->
<!-- Bootstrap CSS -->
<link href="/css/card.css" rel="stylesheet" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>




<!--  Access the Static Resources without using spring URL -->
<link href="/css/style.css" rel="stylesheet" />
<script src="/js/custom.js"></script>


</head>

<body>

	<%@ include file="header.jsp"%>


	<!-- First Container -->
	<div class="container-fluid bg-1">
		<div>
			<h2 class="text-center">Car List</h2>

			<c:if test="${not empty error_message}">
				<p>${error_message}</p>
			</c:if>

			<c:if test="${empty cars}">
				<sec:authorize access="hasRole('Administrator')">
					<span> No Cars are added yet. </span>
				</sec:authorize>
				<sec:authorize access="hasRole('Users')">
					<span> Please click on Add button to add Cars to the system.
					</span>
				</sec:authorize>
			</c:if>


			<!--  All Car Lists  -->

			<div class="row">
				<div class="col-md-12">

					<sec:authorize access="hasRole('Users')">
						<a href="new_car">
							<button class="btn btn-primary">Post A Car For Sale</button>
						</a>
					</sec:authorize>

					<c:url var="get_search_url" value="search" />
					<form action="${get_search_url}" id="myform" method="get"
						class="form-inline text-right" style="padding: 20px;">

						<input class="form-control mr-sm-2" type="search"
							placeholder="Search" value="" name="keyword" /> <input
							type="submit" value="Search" class="btn btn-info" />

					</form>

				</div>
			</div>






			<div class="row">

				<div class="col-md-12">

					<div class="card-group">

						<c:if test="${not empty cars}">



							<%
							int i = 1;
							%>
							<c:forEach var="car" items="${cars}">

								<div class="card">
									<img src="/images/${car.carphoto}"  class="card-img-top">
									<div class="card-body">
										<h5 class="card-title">${car.price}</h5>
										<p class="card-text">
										<p>Car Make : ${car.make}</p>
										<p>Car Model: ${car.model}</p>
										<p>Car Reg :${car.registeration}</p>
										<p>Sell Price:${car.price}</p>

										<p class="card-text">
											<small class="text-muted"> 
											<sec:authorize
													access="hasRole('Administrator')">
													<a href="edit?id=${car.id}">
														<button class="btn btn-info">Update</button>
													</a>
													<a href="delete?id=${car.id}">
														<button class="btn btn-danger">Delete</button>
													</a>
											</sec:authorize> 
												<a href="car_detail?id=${car.id}">
													<button class="btn btn-info">View</button></a> 
											</small>
										</p>
									</div>
								</div>

								<%
								i++;
								%>
							</c:forEach>



						</c:if>

					</div>
					<!-- End of Card -->

				</div>
			</div>

			<!--  End Car Lists  -->

		</div>
	</div>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<%@ include file="footer.jsp"%>
</body>
</html>