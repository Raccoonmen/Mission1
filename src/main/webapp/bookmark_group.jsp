<%@ page import="okhttp3.*" %>
<%@page import="DB.Member"%>
<%@page import="DB.Api_Data"%>
<%@page import="DB.bookmark"%>
<%@page import="DB.history_data"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kotlin.*"%>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <!-- 
   북마크 그룹 관리를 눌렀을때, 생성한 북마크 그룹들을 보여주는 페이지 입니다.
   book.bookmark_gorup_list를 통해서 DB에서 리스트를 만들어 보여줍니다.
   삭제와 수정이 구현되어 있습니다. 
   id나 그룹이름 등은 중복될 수 있으니 삭제나 수정할 그룹을 확정짓는데 regi_date를 사용합니다.
    -->
    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>북마크 그룹</title>
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
	bookmark book = new bookmark(); 
	List<Member> bookmark_group_list = book.bookmark_group_list();
	%>



	<h1> 북마크 그룹 </h1>
	<a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
	<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
	<a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>
	
    <div class="section-gap"></div>
    
	<form>
        <button type="button" onclick="location.href='bookmark_group_plus.jsp'">북마크 그룹 이름 추가</button>  
    </form>

	<table id="customers">
	<colgroup>
		<col style="width: 12%;"/>
		<col style="width: 23%;"/>
		<col style="width: 12%;"/>
		<col style="width: 23%;"/>
		<col style="width: 15%;"/>
		<col style="width: 10%;"/>
	</colgroup>
		<thead>
			<tr >
				<th> ID </th>
				<th> 북마크 이름 </th>
				<th> 순서 </th>
				<th> 등록일자 </th>
				<th> 수정일자 </th>
				<th> 비고 </th>		
			</tr>
		</thead>
		<tbody>
			<%
			// bookmark_group_list를 order_num으로 오름차순 정렬
			Collections.sort(bookmark_group_list, new Comparator<Member>() {
			    public int compare(Member member1, Member member2) {
			        return member1.getOrder_num().compareTo(member2.getOrder_num());
			    }
			});
			%>				
			<%
					
				boolean isWhiteRow = true;
				for(Member member : bookmark_group_list) {
					String rowColor = isWhiteRow ? "white" : "#F2F2F2";
					
			%>	
			<%
				if(bookmark_group_list.isEmpty()){
			%>		
				<tr>
					<td colspan="17" style="font-size: 24px; font-weight: bold;">북마크 그룹이 존재하지 않습니다.</td>
				</tr>	
			<%
				}
			%>
				<tr style="background-color: <%=rowColor%>;">
					<td><%=member.getId()%></td>
					<td><%=member.getBookmark_name()%></td>
					<td><%=member.getOrder_num()%></td>
					<td><%=member.getRegi_date()%></td>
					<td><%=member.getModi_date()%></td>
					<td style="text-align: center;">	
					<a href="update_bookmark_group.jsp?delete=true&regi_date=<%=member.getRegi_date()%>">수정</a>
					<a href="delete_bookmark.jsp?delete=true&regi_date=<%=member.getRegi_date()%>">삭제</a>
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