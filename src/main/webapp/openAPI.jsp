<%@ page import="okhttp3.*" %>
<%@ page import="DB.Member" %>
<%@ page import="DB.Api_Data" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="kotlin.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!-- 
Open API 와이파이 정보 가져오기를 클릭하면 들어오는 페이지입니다.
해당 페이지에서는 apiData.api_data메서드를 사용해서 api에서 데이터를 DB에 저장합니다.
그리고 해당 메서드에서 end라는 끝번호 값을 가져와서 x개의 데이터를 가져왔다. 를 표시합니다.
 -->


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>와이파이 정보 구하기</title>
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

<h1>와이파이 정보 구하기</h1>
<a href="index.jsp">홈</a>
<a href="history.jsp">위치 히스토리 목록</a>
<a href="bookmark.jsp">북마크 보기</a>
<a href="bookmark_group.jsp">북마크 그룹 관리</a>

<%
    // Api_Data 클래스의 인스턴스를 생성하고 메소드를 호출합니다.
    Api_Data apiData = new Api_Data();
    apiData.api_data(request); //endValue를 가져오기 위해 request
    
    Integer endValue = (Integer) request.getAttribute("endValue"); //api_data에서 가져온 데이터의 끝 번호 endValue
    int end = (endValue != null) ? endValue.intValue() : 0;
%>

<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>


    <div class="section-gap"></div>
    
	<table id="customers">
    <colgroup>
        <col style="width: 4%;"/>
        <col style="width: 6%;"/>
        <col style="width: 3%;"/>
        <col style="width: 7%;"/>
        <col style="width: 7%;"/>
        <col style="width: 15%;"/>
        <col style="width: 5%;"/>
        <col style="width: 7%;"/>
        <col style="width: 5%;"/>
        <col style="width: 5%;"/>
        <col style="width: 5%;"/>
        <col style="width: 4%;"/>
        <col style="width: 4%;"/>
        <col style="width: 5%;"/>
        <col style="width: 5%;"/>
        <col style="width: 5%;"/>
        <col style="width: 8%;"/>
    </colgroup>
    <thead>
    <tr style="background-color: #00B373; color:white; font-size: 16px;">
        <th>거리(km)</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WIFI접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td colspan="17" style="font-size: 24px; font-weight: bold; text-align: center; ">
            위치정보 <%= end %>개의 와이파이 정보를 정상적으로 저장했습니다.
            <br>
            <a href="index.jsp" style="font-size: 18px;">홈으로 돌아가기</a>
        </td>
    </tr>
    </tbody>
</table>
</body>
</html>
