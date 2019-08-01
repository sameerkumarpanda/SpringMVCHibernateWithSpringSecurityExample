<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Policy Application</title>
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
		$('#pendingclaims').DataTable({
			"dom" : '<"top"i>rt<"bottom"p><"clear">',
			"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                if ( aData[2] == "NEW" || aData[2] == "new")
                {
					$('td', nRow).addClass('table-success');
                }
                else if(aData[2] == "INPROGRESS" || aData[2] == "inprogress")
                {
					$('td', nRow).addClass('table-info');
                }
				else if(aData[2] == "PENDING" || aData[2] == "PENDING")
                {
					$('td', nRow).addClass('table-warning');
                }else{
					$('td', nRow).addClass('table-primary');
				}
            }
		});
		$('#dashboard').DataTable({
			"dom" : '<"top"i>rt<"bottom"p><"clear">'
		});
		$('#pendingpayments').DataTable({
			"dom" : '<"top"i>rt<"bottom"p><"clear">',
			"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                if ( aData[4] != "" )
                {
					$('td', nRow).addClass('table-warning');
                }
            }
		});
	});
</script>
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
				<h2>DashBoard</h2>
				<h6>
					As on <span class="spanmonthyear"></span>
				</h6>
				<p />
				<table id="dashboard" class="table">
					<thead>
						<tr>
							<th>Total Policies</th>
							<th>Active Policies</th>
							<th>Total Claims</th>
							<th>Pending Claims</th>
						</tr>
					</thead>
					<tbody>
						<tr class="table-info">
							<td><c:out value="${allpoliciescount}" /></td>
							<td><c:out value="${activepoliciescount}" /></td>
							<td><c:out value="${allclaimscount}" /></td>
							<td><c:out value="${activeclaimscount}" /></td>
						</tr>
					</tbody>
				</table>
				<br>
				<h2>Pending Claims</h2>
				<h6>
					As on <span class="spanmonthyear"></span>
				</h6>
				<table id="pendingclaims" class="table">
					<thead>
						<tr>
							<th>Claim Number</th>
							<th>Claim Type</th>
							<th>Status</th>
							<th>Created Date</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allclaims}" var="claim">
					<tr>
						<td>${claim.claimId}</td>
						<td>${claim.claimType}</td>
						<td>${claim.status}</td>
						<td>${claim.claimStartDate}</td>
					</tr>
				</c:forEach>
					</tbody>
				</table>
				<br>
				<h2>Pending Payments</h2>
				<h6>
					As on <span class="spanmonthyear"></span>
				</h6>
				<table id="pendingpayments" class="table">
					<thead>
						<tr>
							<th>Policy Number</th>
							<th>Policy Type</th>
							<th>Balance</th>
							<th>Payment Date</th>
							<th>Renewal Amount</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${allpolicies}" var="policy">
					<c:if test="${not empty policy.renewalAmount}" >
					<tr>
						<td>${policy.policyId}</td>
						<td>${policy.policyType}</td>
						<td>${policy.policyAmount}</td>
						<td>${policy.policyEndDate}</td>
						<td>${policy.renewalAmount}</td>
					</tr>
					</c:if>
					</c:forEach>
					</tbody>
				</table>
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
<%-- <div class="panel panel-default">
			  <!-- Default panel contents -->
		  	<div class="panel-heading"><span class="lead">List of Users </span></div>
			<table class="table table-hover">
	    		<thead>
		      		<tr>
				        <th>Firstname</th>
				        <th>Lastname</th>
				        <th>Email</th>
				        <th>SSO ID</th>
				        <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
				        	<th width="100"></th>
				        </sec:authorize>
				        <sec:authorize access="hasRole('ADMIN')">
				        	<th width="100"></th>
				        </sec:authorize>
				        
					</tr>
		    	</thead>
	    		<tbody>
				<c:forEach items="${users}" var="user">
					<tr>
						<td>${user.firstName}</td>
						<td>${user.lastName}</td>
						<td>${user.email}</td>
						<td>${user.ssoId}</td>
					    <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
							<td><a href="<c:url value='/edit-user-${user.ssoId}' />" class="btn btn-success custom-width">edit</a></td>
				        </sec:authorize>
				        <sec:authorize access="hasRole('ADMIN')">
							<td><a href="<c:url value='/delete-user-${user.ssoId}' />" class="btn btn-danger custom-width">delete</a></td>
        				</sec:authorize>
					</tr>
				</c:forEach>
	    		</tbody>
	    	</table>
		</div>
		<sec:authorize access="hasRole('ADMIN')">
		 	<div class="well">
		 		<a href="<c:url value='/newuser' />">Add New User</a>
		 	</div>
	 	</sec:authorize> --%>
</body>
</html>
