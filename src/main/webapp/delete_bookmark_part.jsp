<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.bookmark" %>

<!-- 
실질적으로 북마크를 삭제하는 부분입니다. 
bookmark.jsp에서 기능됩니다.
book.delete_Bookmark_Part로 북마크를 삭제합니다.
 -->

<%
    // DB에서 데이터 삭제하는 로직 작성
	bookmark book = new bookmark();
    
    // form에서 전달된 id 값을 가져오기
    String regi_Date = request.getParameter("regi_date");
    
    // 해당 ID의 데이터 삭제
    book.delete_Bookmark_Part(regi_Date);
    
    // 삭제 후에 다시 history 페이지로 리다이렉트
    String message = "북마크를 삭제하였습니다.";
    out.println("<script>alert('" + message + "'); window.location.href='bookmark.jsp';</script>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>