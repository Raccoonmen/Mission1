<%@ page import="okhttp3.*" %>
<%@page import="DB.Member"%>
<%@page import="DB.Api_Data"%>
<%@page import="DB.history_data"%>
<%@page import="DB.bookmark"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kotlin.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- 
 북마크 그룹을 추가하는 페이지 입니다.
 input에 입력한 값을 book.bookmark_group메서드를 사용해서 북마크 그룹을 추가합니다.
  -->
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>북마크 그룹 추가</title>
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
	}
	.section-gap {
	  margin-bottom: 10px;
	}
	</style>
</head>
<body>
	<% 
    bookmark book = new bookmark(); 
    List<Member> memberList = null;
    
    // form에서 전달된 값을 가져옵니다.
    String nameParam = request.getParameter("name");
    String orderParam = request.getParameter("order");
    
    // 가져온 값을 bookmark_group 메서드에 전달하여 사용합니다.
    if (nameParam != null && orderParam != null) {
        String bookmarkName = nameParam;
        Integer orderNum = Integer.parseInt(orderParam);
        book.bookmark_group(bookmarkName, orderNum);
    }
    
    %>

	<br>
	<h1> 북마크 그룹 추가 </h1>
	<a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
	<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
	<a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>
    

	<div class="section-gap"></div>
    <form method="post" action="">
        <table id="customers">
            <colgroup>
                <col style="width: 30%;"/>
                <col style="width: 70%;"/>
            </colgroup>
            <thead>
                <tr>
                    <th>북마크 이름</th>
                    <td>
                        <input type="text" name="name" id="nameValue" value="">
                    </td>
                </tr>
                <tr>
                    <th>순서</th>
                    <td>
                        <input type="text" name="order" id="orderValue" value="">
                    </td>
                </tr>
				<tr>
				  <td colspan="2" style="text-align: center;">
				    <a href="bookmark_group.jsp">돌아가기</a>
				    <button style="display: inline-block;" type="submit">추가</button>
				  </td>
				</tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </form>


    <% 
    // 북마크 그룹이 만들어졌음을 알리는 alert를 출력합니다.
    if (nameParam != null && orderParam != null) { %>
        <script>
            alert('북마크 그룹이 만들어졌습니다.');
            window.location.href = 'bookmark_group.jsp';
        </script>
    <% } %>
</body>
</html>