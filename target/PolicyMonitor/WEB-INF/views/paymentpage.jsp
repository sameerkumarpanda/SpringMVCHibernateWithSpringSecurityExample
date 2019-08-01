<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Register claim</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
<script>
	$(document).ready(function() {
		
	});
</script>
<style>
.has-error{
	color:red;
}
</style>
</head>
<body>
	<%@include file="authheader.jsp" %>
	<%@include file="navBar.jsp" %>

	<div class="container" style="margin-top: 30px">
		<div class="row">
			<div class="col-sm-4">
				<p>Welcome to EPRC online Application</p>
				<p>About Application...</p>

			</div>
			<div class="col-sm-8">
			<form:form method="POST" modelAttribute="policy" class="form-horizontal">
			<input type="hidden" id="policyAmount" ></input>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="policyId">Policies</label>
					<div class="col-md-7">
						<form:select path="policyId" items="${allpolicies}" itemValue="policyId" itemLabel="policyType" class="form-control input-sm"  />
						<div class="has-error">
							<form:errors path="policyId" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			
			
		</form:form>


			</div>
		</div>
	</div>

	<div class="jumbotron text-center" style="margin-bottom: 0">
		<p>&copy; 2019, Powered by EPRC</p>
	</div>
	<script>
		var d = new Date();
		var months = [ "January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November",
				"December" ];
		var displayDate = d.getDate() + " " + months[d.getMonth()] + ", "
				+ d.getFullYear();
		var els = document.getElementsByClassName("spanmonthyear");
		for (var i = 0; i < els.length; i++) {
			els.item(i).innerHTML = displayDate;
		}
	</script>
</body>
</html>