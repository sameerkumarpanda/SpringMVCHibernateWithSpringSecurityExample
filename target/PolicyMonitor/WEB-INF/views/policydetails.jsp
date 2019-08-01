<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<title>Policy Details</title>
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
		$('#pendingpolicies').DataTable({
			"dom" : '<"top"i>rt<"bottom"p><"clear">',
                "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                    if ( aData[6] != "" )
                    {
						$('td', nRow).addClass('table-success');
                    }
                    else 
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
			
			<div class="col-sm-16">
				<div class="row">
					<div class="col-sm-8">
						<h2>Policies</h2>
						<h6>
							As on <span class="spanmonthyear"></span>
						</h6>
					</div>
					<div class="col-sm-4">
						<h5>Register new policy -->&nbsp;<a href="<c:url value='/newpolicy' />">Click Here</a></h5>
					</div>
				</div>
				<table id="pendingpolicies" class="table">
					<thead>
						<tr>
							<th>Policy Number</th>
							<th>Policy Type</th>
							<th>Policy Amount</th>
							<th>Policy Start Date</th>
							<th>Policy End Date</th>
							<th>Policy Description</th>
							<th>Renewal Amount</th>
						</tr>
					</thead>
					<tbody>
				<c:forEach items="${allpolicies}" var="policy">
					<tr>
						<td>${policy.policyId}</td>
						<td>${policy.policyType}</td>
						<td>${policy.policyAmount}</td>
						<td>${policy.policyStartDate}</td>
						<td>${policy.policyEndDate}</td>
						<td>${policy.policyDescription}</td>
						<td>${policy.renewalAmount}</td>
					</tr>
				</c:forEach>
	    		</tbody>
				<tfoot>
            <tr>
                <th colspan="7">*click on each policy number to view more details..</th>
            </tr>
        </tfoot>
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

</body>
</html>
