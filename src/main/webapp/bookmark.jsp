<%@ page import="okhttp3.*" %>
<%@page import="DB.Member"%>
<%@page import="DB.Api_Data"%>
<%@page import="DB.bookmark"%>
<%@page import="DB.history_data"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kotlin.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <!-- 
    detail_wifi, 즉 와이파이 상세보기에서 추가한 북마크들이 보여지는 페이지 입니다.
    북마크 삭제가 구현되어 있습니다. 북마크 삭제는 regi_date를 사용해 특정 짓습니다.
     -->
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>북마크 목록</title>
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
	  text-align: left;
	  background-color: #04AA6D;
	  color: white;
	  text-align: center;
	}
	.section-gap {
	  margin-bottom: 10px;
	}
	</style>
</head>
<body>
	<% 	
	bookmark book = new bookmark(); 
	List<Member> bookmark_list = book.bookmark_list();
	%>



	<h1> 북마크 목록 </h1>
	<a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
	<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
	<a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>
    

	<div class="section-gap"></div>
	<table id="customers">
	<colgroup>
		<col style="width: 8%;"/>
		<col style="width: 23%;"/>
		<col style="width: 33%;"/>
		<col style="width: 23%;"/>
		<col style="width: 8%;"/>		
	</colgroup>
		<thead>
			<tr>
				<th> ID </th>
				<th> 북마크 이름 </th>
				<th> 와이파이명 </th>
				<th> 등록일자 </th>
				<th> 비고 </th>		
			</tr>
		</thead>
		<tbody>			
			<%
					
				boolean isWhiteRow = true;
				for(Member member : bookmark_list) {
					String rowColor = isWhiteRow ? "white" : "#F2F2F2";
					
			%>	
			<%
				if(bookmark_list.isEmpty()){
			%>		

				<tr>
					<td colspan="17" style="font-size: 24px; font-weight: bold;">북마크를 추가해 주세요.</td>
				</tr>	
			<%
				}
			%>
				<tr style="background-color: <%=rowColor%>;">
					<td><%=member.getId()%></td>
					<td><%=member.getBookmark_name()%></td>					
					<td><a href="detail_wifi.jsp?wifi_name=<%=member.getWifi_name()%>"><%=member.getWifi_name()%></a></td>								
					<td><%=member.getRegi_date()%></td>
					<td style="text-align: center;">
					    <a href="delete_bookmark_part.jsp?delete=true&regi_date=<%=member.getRegi_date()%>">삭제</a>
					</td>
				</tr>
			<%
					isWhiteRow = !isWhiteRow;
					}				
			%>
		</tbody>
	</table>
</body>
</html>