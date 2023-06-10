<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.history_data" %>

<!-- 
  DB에서 히스토리 데이터를 삭제하는 로직입니다.
  history.jsp에서 기능합니다.
 history_data.deleteData로 히스토리가 id값에 따라 삭제됩니다.
 -->

<%   
    history_data his = new history_data();
    
    // form에서 전달된 id 값을 가져오기
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);
    
    // 해당 ID의 데이터 삭제
    his.deleteData(id);
    
    // 삭제 후에 다시 history 페이지로 리다이렉트
    response.sendRedirect("history.jsp");
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