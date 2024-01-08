<%@ page contentType="text/html; charset=US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ page import="com.lithan.ac.springboot_car_portal_demo.entities.Car"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<style>
        body {
            background: linear-gradient(to top, #FFFFFF, #b3ffda);
        }
    </style>
<!--  Enable Bootstrap -->
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

	<!-- Test My JS -->
	<!-- <input type="button" class="button" onclick="sayHello();" value="Click me!">  -->

	<%@ include file="header.jsp"%>


	<!-- First Container -->
	<div class="container-fluid bg-1 text-center">
		<h3 class="margin">Post A Car For Sale !</h3>

		<div class="row">

			<div class="col-md-4"></div>

			<div class="col-md-4">


				<!--
            It is standard practice to have all action & href urls wrapped with c:url tag.
            This tag adds jsessionid to the action/href url, in case cookies are disabled by the user.
       			 -->


				<form:form method="POST" action="/cars" modelAttribute="car"
					enctype="multipart/form-data">

					<input type="hidden" value="${_csrf.token}" />
					<form:hidden path="id" />

					<c:if test="${car.id>0}">
						<div class="form-group">
							<img src="/images/${car.carphoto}" width="300px">
							<form:hidden path="carphoto" />
						</div>
					</c:if>

					<div class="form-group">
						<label for="carphoto">Upload Car Photo:</label> 
						<input type="file" name="file" />
					</div>


					<div class="form-group">
						<form:label path="make">Car Make:</form:label>
						<form:input path="make" />
					</div>


					<div class="form-group">
						<label for="model">Car Model:</label>
						<form:input path="model" />
					</div>

					<div class="form-group">
						<label for="registeration"> registeration:</label>
						<form:input path="registeration" />

					</div>

					<div class="form-group">
						<label for="price">Car Price:</label>
						<form:input path="price" />
					</div>

					<input type="submit" name="Add" value="Save" />
					<input type="button" value="Cancel" onclick="cancel()" />

					<script>
						function cancel() {
							window.location.href = "cars"
						}
					</script>
				</form:form>
			</div>


			<div class="col-md-4"></div>

		</div>

	</div>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<%@ include file="footer.jsp"%>

</body>
</html>
