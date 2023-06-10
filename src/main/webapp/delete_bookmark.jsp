<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.bookmark" %>

<!-- 
DB에서 북마크 그룹을 삭제하는 부분입니다.
bookmark_group.jsp에서 기능합니다.
book.delete_Bookmark_Group로 삭제합니다.
 -->

<%
    // form에서 전달된 등록일자값을 가져오기
    String regi_Date = request.getParameter("regi_date");
       
    // 해당 등록일자의 북마크 그룹 삭제
    bookmark book = new bookmark();
    book.delete_Bookmark_Group(regi_Date);
    
    // 삭제 후에 다시 bookmark_group 페이지로 리다이렉트
    String message = "북마크 그룹을 삭제하였습니다.";
    out.println("<script>alert('" + message + "'); window.location.href='bookmark_group.jsp';</script>");
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