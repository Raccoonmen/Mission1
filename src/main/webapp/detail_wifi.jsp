<%@page import="DB.Member"%>
<%@page import="DB.bookmark"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DB.wifi_service"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!-- 
와이파이 상세보기 페이지
북마크 추가하기를 위해서 북마크 그룹을 가져와서
select > option에 넣는다.
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
	}
	
	.list-bar {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  background-color: #f2f2f2;
	  padding: 10px;
	}
	
	button {
	  margin: 0 5px;
	  padding: 5px 10px;
	  background-color: #fff;
	  border: 1px solid #ccc;
	  border-radius: 5px;
	  cursor: pointer;
	}
	
	button:hover {
	  background-color: #e6e6e6;
	}
	
	.section-gap {
	  margin-bottom: 10px;
	}
	</style>
</head>
<body>

	<%
	//해당 와이파이 상세보기를 위한 와이파이 이름정보
	String wifiName = request.getParameter("wifi_name");
	%>
	
    <%
    	wifi_service wifi = new wifi_service();
        List<Member> detail_List = wifi.detail(wifiName);                  
        
        bookmark book= new bookmark();
        List<Member> bookmark_group = book.bookmark_group_name(); 
    %>

    <h1> 와이파이 정보 구하기 </h1>
    <a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
    <a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>
	<br>
	
	<div class="section-gap"></div>
	
	<!-- 북마크 그룹을 선택하기 위해서 option으로 북마크 그룹 이름을 검색해서 반복해서 넣는다.  -->
	<form id="bookmarkForm" method="get" action="bookmark.jsp">
	  <select id="bookmarkName" name="bookmarkName">
	    <option value="">북마크 그룹이름 선택</option>
	    <% for (Member member : bookmark_group) { %>
	        <option value="<%= member.getBookmark_name() %>"><%= member.getBookmark_name() %></option>
	    <% } %>
	  </select>
	  <button type="button" onclick="submitForm()" ;>북마크 추가하기</button>
	</form>
	
	
	<!--
	  원하는 옵션을 선택하고 북마크 추가하기를 누르면, 클릭 이벤트에 의해 submitForm함수가 실행된다. 
	  submitForm는 선택한 북마크 그룹을 가져와서 bookmark_add.jsp로 선택한 북마크 그룹과 추가할 와이파이 이름을 보낸다.
	 -->
	<script>
	  function submitForm() {
	    var selectedBookmark = document.getElementById("bookmarkName").value;
	    if (selectedBookmark !== "") {
	      var wifiName = '<%= wifiName %>';
	      window.location.href = 'bookmark_add.jsp?bookmarkName=' + selectedBookmark + '&wifi_name=' + wifiName;
	    } else {
	      alert("북마크 그룹을 선택해주세요.");
	    }
	  }
	</script>
  
    <table id="customers">
	<colgroup>
		<col style="width: 25%;"/>
		<col style="width: 75%;"/>

	</colgroup>
    
    <thead>
    </thead>
		<tbody>
		    <%
		    boolean isWhiteRow = true;
		    if (!detail_List.isEmpty()) {
		        Member member = detail_List.get(0);
		        String rowColor = isWhiteRow ? "white" : "#F2F2F2";
		    %>
		        <tr style="background-color: <%=rowColor%>;">
		        <tr>
	                <th> 거리(km) </th>
	                <td>
	                	<%=member.getDistance()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 관리번호 </th>
	                <td>
	                    <%=member.getMan_num()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 자치구 </th>
	                <td>
	                    <%=member.getBorough()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 와이파이명 </th>
	                <td>
	                    <%=member.getWifi_name()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 도로명주소 </th>
	                <td>
	                    <%=member.getRoad_num()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 상세주소 </th>
	                <td>
	                    <%=member.getDetail_addr()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 설치위치(층) </th>
	                <td></td>
	            </tr>
	            <tr>
	                <th> 설치유형 </th>
	                <td>
	                    <%=member.getIns_type()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 설치기관 </th>
	                <td>
	                    <%=member.getIns_age()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 서비스구분 </th>
	                <td>	                    
	                    <%=member.getService()%>
	                </td>
	            </tr>
	            <tr>
	                <th> 망종류 </th>
	                <td>
	                    <%=member.getNetwork()%>
	                </td>
	            </tr>	        
	            <tr>
	                <th> 설치년도 </th>
	                <td>
	                    <%=member.getIns_year()%>
	                </td>
	            </tr>	        
	            <tr>
	                <th> 실내외구분 </th>
	                <td>
	                    <%=member.getIn_out()%>
	                </td>
	            </tr>	        
	            <tr>
	                <th> WIFI접속환경 </th>
	                <td>
	                    
	                </td>
	            </tr>	        
	            <tr>
	                <th> X좌표 </th>
	                <td>
	                    <%=member.getX_coor()%>
	                </td>
	            </tr>	        
	            <tr>
	                <th> Y좌표 </th>
	                <td>
	                    <%=member.getY_coor()%>
	                </td>
	            </tr>	        
	            <tr>
	                <th> 작업일자 </th>
	                <td>
	                    <%=member.getWork_date()%>
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