<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.bookmark" %>
<!-- 
북마크 그룹을 수정(업데이트)하는 실질적인 부분입니다.
update_bookmark_group.jsp에서 가져온 파라미터들을 이용해서 
book.bookmark_group_update를 실행해서 원하는 값으로 북마크 그룹을 수정합니다.
 -->


<%
    // DB에서 데이터 업데이트 하는 로직
    bookmark book = new bookmark();

	String idParam = request.getParameter("id");
	String bookmarkParam = request.getParameter("bookmark");
	String orderParam = request.getParameter("order_num");
	String regiDateParam = request.getParameter("regi_date");
	
	
    int id = Integer.parseInt(idParam);
    String bookmark = bookmarkParam;
    int order = Integer.parseInt(orderParam);
    String regi = regiDateParam;

    
    // 해당 regi의 데이터를 업데이트
    book.bookmark_group_update(id, bookmark, order, regi);
    
    // 업데이트 후에 다시 bookmark_group 페이지로 리다이렉트
%>

<script>
    var id = <%= id %>;
    var bookmark = "<%= bookmark %>";
    var order = <%= order %>;
    var regi = "<%= regi %>";
    var message = "업데이트된 데이터:\nID: " + id + "\n북마크: " + bookmark + "\n순서: " + order + "\n등록일: " + regi;
    alert(message);
    location.href = "bookmark_group.jsp";
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>