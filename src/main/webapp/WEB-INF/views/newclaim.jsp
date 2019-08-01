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
			<form:form method="POST" modelAttribute="claim" class="form-horizontal">
			<form:input type="hidden" path="claimId" id="claimId"/>
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
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="claimType">Claim Type</label>
					<div class="col-md-7">
						<form:input type="text" path="claimType" id="claimType" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="claimType" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="claimDescription">Claim Description</label>
					<div class="col-md-7">
						<form:input type="text" path="claimDescription" id="claimDescription" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="claimDescription" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="claimStartDate">Start Date</label>
					<div class="col-md-7">
						<form:input type="date" path="claimStartDate" id="claimStartDate" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="claimStartDate" class="has-error"/>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="claimEndDate">End Date</label>
					<div class="col-md-7">
						<form:input type="date" path="claimEndDate" id="claimEndDate" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="claimEndDate" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="claimAmount">Claim Amount</label>
					<div class="col-md-7">
						<form:input type="number" path="claimAmount" id="claimAmount" class="form-control input-sm"  />
						<div class="has-error">
							<form:errors path="claimAmount" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="remarks">Remarks</label>
					<div class="col-md-7">
						<form:input type="text" path="remarks" id="remarks" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="remarks" class="has-error"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<c:choose>
						<c:when test="${edit}">
						<label class="col-md-3 control-lable" for="status">Status</label>
						<div class="col-md-7">
						<form:input type="text" path="status" id="status" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="status" class="has-error"/>
						</div>
						</div>
						</c:when>
						<c:otherwise>
							<form:input type="hidden" path="status" id="status" value="NEW"/>
						</c:otherwise>
					</c:choose>
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
							<input type="submit" value="Register" class="btn btn-primary btn-sm"/> or <a href="<c:url value='/allclaims' />">Cancel</a>
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