<%@ page import="okhttp3.*" %>
<%@ page import="DB.Member" %>
<%@ page import="DB.Api_Data" %>
<%@ page import="DB.bookmark" %>
<%@ page import="DB.history_data" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="kotlin.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<!--
북마크 그룹을 수정하는 페이지 
input에서 입력받은 내용을 수정버튼을 이용해 submit해서 
실제로 수정하는 작업은 update_bookmark.jsp에서 실행
-->

<html>
<head>
	<meta charset="UTF-8">
	<title>북마크 그룹 수정하기</title>
	<style>
	#customers {
	  font-family: Arial, Helvetica, sans-serif;
	  border-collapse: collapse;
	  width: 100%;
	}
	
	#customers td, #customers th {
	  border: 1px solid #ddd;
	  padding: 8px;
	}
	
	#customers tr:nth-child(even){background-color: #f2f2f2;}
	
	#customers tr:hover {background-color: #ddd;}
	
	#customers th {
	  padding-top: 12px;
	  padding-bottom: 12px;
	  text-align: center;
	  background-color: #04AA6D;
	  color: white;
	}
	.section-gap {
	  margin-bottom: 10px;
	}
	</style>
</head>
<body>
	<% 	
	String regi_Date = request.getParameter("regi_date");
	
	bookmark book = new bookmark(); 
	List<Member> bookmark_group_member = book.bookmark_group_update_list(regi_Date);
	%>

	<h1> 북마크 그룹 수정하기 </h1>
	<a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
	<a href="list.jsp">Open API 와이파이 정보 가져오기</a>
	<a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>
	
	<div class="section-gap"></div>
	<table id="customers">
	<colgroup>
		<col style="width: 12%;"/>
		<col style="width: 23%;"/>
		<col style="width: 12%;"/>
		<col style="width: 43%;"/>
		<col style="width: 15%;"/>		
	</colgroup>
		<thead>
			<tr>
				<th> ID </th>
				<th> 북마크 이름 </th>
				<th> 순서 </th>
				<th> 등록일자 </th>
				<th> 비고 </th>		
			</tr>
		</thead>

	<tbody>
	  <tr>
	  	<!--  -->
	    <form action="update_bookmark.jsp" method="get">
	      <% 
	      if (!bookmark_group_member.isEmpty()) {
	        Member member = bookmark_group_member.get(0); 
	      %>
	      <tr>
	        <td><input type="text" name="id" placeholder="아이디를 입력하세요"  value="<%=member.getId()%>"></td>
	        <td><input type="text" name="bookmark" placeholder="북마크를 입력하세요" value="<%=member.getBookmark_name()%>"></td>
	        <td><input type="text" name="order_num" placeholder="순서를 입력하세요" value="<%=member.getOrder_num()%>"></td>
	        <td><input type="text" name="regi_date" placeholder="등록일자를 입력하세요" value="<%=regi_Date%>"></td>
			<td style="text-align: center;">
			  <button type="submit">수정</button>
			</td>
	      </tr>
	      <% } %>
	    </form>
	  </tr>
	</tbody>


	</table>
</body>
</html>
