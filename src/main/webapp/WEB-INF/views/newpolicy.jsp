<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Register Policy</title>
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
			<form:input type="hidden" path="policyId" id="policyId"/>
			<form:input type="hidden" path="ssoId" id="ssoId" value="${loggedinuser}"/>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="policyType">Policy Type</label>
					<div class="col-md-7">
						<form:input type="text" path="policyType" id="policyType" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="policyType" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="policyDescription">Policy Description</label>
					<div class="col-md-7">
						<form:input type="text" path="policyDescription" id="policyDescription" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="policyDescription" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="policyStartDate">Start Date</label>
					<div class="col-md-7">
						<form:input type="date" path="policyStartDate" id="policyStartDate" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="policyStartDate" class="has-error"/>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="policyEndDate">End Date</label>
					<div class="col-md-7">
						<form:input type="date" path="policyEndDate" id="policyEndDate" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="policyEndDate" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="policyAmount">Policy Amount</label>
					<div class="col-md-7">
						<form:input type="number" path="policyAmount" id="policyAmount" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="policyAmount" class="has-error"/>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
			<div class="form-group col-md-12">
					<div class="col-md-7">
				<div class="form-actions floatRight">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Update" class="btn btn-primary btn-sm"/> or <a href="<c:url value='/list' />">Cancel</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Register" class="btn btn-primary btn-sm"/> or <a href="<c:url value='/allpolicies' />">Cancel</a>
						</c:otherwise>
					</c:choose>
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
