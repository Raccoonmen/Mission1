<%@ page import="okhttp3.*" %>
<%@page import="DB.Member"%>
<%@page import="DB.Api_Data"%>
<%@page import="DB.history_data"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kotlin.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 
이때까지 검색한 위도 경도의 검색기록이 남는 히스토리페이지 입니다.
삭제가 구현되어 있습니다.
delete_history.jsp로 해당 히스토리의 id값을 보내서 삭제합니다.     
-->
    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위치 히스토리 목록</title>
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
	 <%--히스토리 맴버,리스트 구성 --%>
	<%
		history_data his = new history_data();
		List<Member> history_list = his.history();
	%>



	<h1> 위치 히스토리 목록 </h1>
	<a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
	<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
	<a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>    
    <br>
    
    <div class="section-gap"></div>
    
	<table id="customers">
	<colgroup>
		<col style="width: 10%;"/>
		<col style="width: 20%;"/>
		<col style="width: 20%;"/>
		<col style="width: 40%;"/>
		<col style="width: 10%;"/>
	</colgroup>
		<thead>
			<tr style="background-color: #00B373; color:white; font-size: 16px;">
				<th> id </th>
				<th> x좌표 </th>
				<th> y좌표 </th>
				<th> 조회일자 </th>
				<th> 비고 </th>			
			</tr>
		</thead>
		<tbody>
		 <%--맴버리스트가 비어있을때는, 입력해달라는 텍스트. --%>
			<%
				if (history_list.isEmpty()) {
			%>		
				<tr>
					<td colspan="17" style="font-size: 24px; font-weight: bold; text-align: center;">위치정보를 입력한 후에 조회해주세요				
		            <br>
		            <a href="index.jsp" style="font-size: 20px;">홈으로 돌아가기</a>
					</td>
				</tr>			
			
			 <%--리스트가 존재할때는, 반복하면서 맴버객체들을 출력 그리고 white면 회색, 회색이면 white로 반복 --%>
			<%			
				} else {

					
				boolean isWhiteRow = true;
				for(Member member : history_list) {
					String rowColor = isWhiteRow ? "white" : "#F2F2F2";
			%>
				<tr style="font-size: 15px; text-align: center;">
				
					<td><%=member.getId()%></td>
					<td><%=member.getH_x_coor()%></td>
					<td><%=member.getH_y_coor()%></td>
					<td><%=member.getCheck_date()%></td>
                    <td>
                        <form method="post" action="delete_history.jsp">
                            <input type="hidden" name="id" value="<%=member.getId()%>">
                            <button type="submit">삭제</button>
                        </form>
                    </td>

				</tr>
			<%
					isWhiteRow = !isWhiteRow;
					}
				}
			%>
		</tbody>
	</table>
</body>
</html>