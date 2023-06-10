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
	detail_wifi에서 선택한 북마크 그룹이름과 wifiName을 이용해서 
	북마크를 추가한다.
  -->
<!DOCTYPE html>
<html>
	<%
	String bookmarkName = request.getParameter("bookmarkName");
	String wifiName = request.getParameter("wifi_name");               
	
	bookmark book = new bookmark();
	List<Member> bookmark_group = book.bookmark_group_name(); 
	
	if (bookmarkName != null && wifiName != null) {
	    int bookmarkId = 0; // 변수 초기화
	
	    // DB에서 해당하는 bookmark_name을 검색하여 id 가져오기
	    for (Member member : bookmark_group) {
	    	//만약 북마크 이름이 내가 선택한 북마크 이름과 같다면, 북마크id가 확정된다.
	        if (member.getBookmark_name().equals(bookmarkName)) {
	            bookmarkId = member.getId();
	            break;
	        }
	    }
	    // 검증 후 bookmarkId가 0이 아니라면 해당하는 북마크 id를 찾은 것이다.
	    // 북마크id를 찾았다면, book.add_bookmark메서드를 실행해서 북마크를 실질적으로 추가한다.
	    if (bookmarkId != 0) {
	        book.add_bookmark(bookmarkId, bookmarkName, wifiName);
	
	        String message = "북마크가 생성되었습니다.";
	        String redirectUrl = "bookmark.jsp";
	        out.println("<script>alert('" + message + "');</script>");
	        out.println("<script>window.location.href = '" + redirectUrl + "';</script>");
	    } else {
	        String message = "북마크 생성에 실패했습니다. 북마크 그룹을 찾을 수 없습니다.";
	        String redirectUrl = "bookmark.jsp";
	        out.println("<script>alert('" + message + "');</script>");
	        out.println("<script>window.location.href = '" + redirectUrl + "';</script>");
	    }
	} else if (bookmarkName != null) {
	    String message = "북마크 생성에 실패했습니다. 와이파이명을 선택해주세요.";
	    String redirectUrl = "bookmark.jsp";
	    out.println("<script>alert('" + message + "');</script>");
	    out.println("<script>window.location.href = '" + redirectUrl + "';</script>");
	}
	%>


<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>