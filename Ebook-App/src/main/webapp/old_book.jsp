<%@page import="com.entity.BookDtls"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.User"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User: Old Book</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">

	<c:if test="${empty userobj }">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<%@include file="all_component/navbar.jsp"%>
	<!-- Start display warning Msg -->
	                    <c:if test="${not empty succMsg }">
							<div class="alert alert-success text-center">${succMsg }</div>
							<c:remove var="succMsg" scope="session" />
						</c:if>
						
						<c:if test="${not empty failedMsg }">
		               		<div class="alert alert-danger text-center" role="alert">${failedMsg }</div>
		                	<c:remove var="failedMsg" scope="session"/>			
	                    </c:if>
	<!-- End display warning Msg -->
												
	<div class="container p-5">

		<table class="table table-striped">
			<thead class="bg-primary text-white">
				<tr>
					<th scope="col">Book Name</th>
					<th scope="col">Author</th>
					<th scope="col">Price</th>
					<th scope="col">Category</th>
					<th scope="col">Action</th>
				</tr>
			</thead>
			<tbody>
			
			<%
			User u=(User)session.getAttribute("userobj");
			String email=u.getEmail();
			
			BookDAOImpl dao=new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list=dao.getBookByOld(email, "Old");
			for(BookDtls b:list)
			{%>
			
			<tr>
				<td><%=b.getBookName() %></td>
				<td><%=b.getAuthor() %></td>
				<td><%=b.getPrice() %></td>
				<td><%=b.getBookCategory() %></td>
				<td>
					<a href="delete_old_book?em=<%=email %>&&id=<%=b.getBookId() %>" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i> Delete</a>
				</td>
			</tr>
			
			<%
				
			}
			%>
		
			</tbody>
		</table>

	</div>

</body>
</html>