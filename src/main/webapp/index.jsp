<%@ page import="okhttp3.*" %>
<%@page import="DB.Member"%>
<%@page import="DB.Api_Data"%>
<%@page import="DB.history_data"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DB.wifi_service"%>
<%@page import="kotlin.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 
가장 처음에 보여질 기본적인 index.jsp페이지 입니다.
여기서는 원하는 lat,lnt나 나의 위치찾기를 통해서 lat,lnt값을 구해서 
해당 값에 해당하는 근처 와이파이 정보를 출력할 수 있습니다.    
wifi_name에 와이파이 상세보기를 위한 링크가 걸려 있습니다.
원하는 와이파이 이름을 클릭하면 해당 와이파이에 대한 detail.wifi.jsp페이지로 이동합니다.
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
	<% 
	// memberService.java의 객체생성, 일단 lat, lnt가 들어와야 list를 구성하므로 아직 null;
	wifi_service wifi = new wifi_service(); 
	List<Member> wifi_List = null;
	%>


	<h1> 와이파이 정보 구하기 </h1>
	<a href="index.jsp">홈</a>
    <a href="history.jsp">위치 히스토리 목록</a>
	<a href="openAPI.jsp">Open API 와이파이 정보 가져오기</a>
	<a href="bookmark.jsp">북마크 보기</a>
	<a href="bookmark_group.jsp">북마크 그룹 관리</a>
    
    
	<form>
	<br>
        <a>LAT:</a>
        <input type="text" name="lat" placeholder="위도를 입력하세요" id="latitude" value="0">
        <a>, LNT:</a>
        <input type="text" name="lnt" placeholder="경도를 입력하세요" id="longitude" value="0">
        <button type="button" onclick="getLocation()">내 위치 가져오기</button>
        <button type="submit">근처 WIFI 정보 보기</button>
    </form>
    
    
    
    <!-- 내 위치의 lat,lnt정보를 구할 수 있는 getLocation함수 입니다. -->
	<script>
	    function getLocation() {
	        if (navigator.geolocation) {
	            navigator.geolocation.getCurrentPosition(showPosition);
	        } else {
	            alert("Geolocation is not supported by this browser.");
	        }
	    }
	
	    function showPosition(position) {
	        var latitude = position.coords.latitude;
	        var longitude = position.coords.longitude;
	        document.getElementById("latitude").value = latitude;
	        document.getElementById("longitude").value = longitude;

	        console.log("LAT:", latitude);
	        console.log("LNT:", longitude);
	    }
	</script>


	<!-- form의 input에서 전달된 lat, lnt값을 이용해서 히스토리에 저장하고, 근처 와이파이를 보기위해 memberService.near_wifi를 실행합니다. -->
    <%
    // form에서 전달된 lat, lnt 값을 가져옵니다.
           String latParam = request.getParameter("lat");
           String lntParam = request.getParameter("lnt");
           float lat = Float.NaN;
           float lnt = Float.NaN;

           // lat, lnt 값이 모두 입력되었을 때만 근처 와이파이 정보를 가져옵니다.
           if (latParam != null && lntParam != null && !latParam.isEmpty() && !lntParam.isEmpty()) {            	
               try {
               	//검색한 lat, lnt를 store_data를 이용해서 검색 히스토리를 저장 
                   lat = Float.parseFloat(latParam);
                   lnt = Float.parseFloat(lntParam);
                   
                   history_data d_data = new history_data();
                   d_data.store_data(lat, lnt); 
                   
                   //MemberService에 저장(lnt, lat에 해당하는)                
       			wifi_List = wifi.near_wifi(lnt, lat);
               } catch (NumberFormatException e) {
                   // lat, lnt 파라미터가 잘못된 형식일 경우 처리할 내용 추가
               }
           }
    %>
    
    
    <!-- 검색을 위해 input에 입력한 lat, lnt값이 바로 사라지지 않고 남아있도록 하는 함수입니다.  -->
<script>
    window.onload = function () {
        var latInput = document.getElementById("latitude");
        var lntInput = document.getElementById("longitude");
        var latParam = '<%= latParam %>';
        var lntParam = '<%= lntParam %>';

        if (latParam !== null && lntParam !== null && latParam !== 'null' && lntParam !== 'null') {
            latInput.value = latParam;
            lntInput.value = lntParam;
        } else {
            latInput.value = '';
            lntInput.value = '';
        }
    }
</script>
    <%

	%>
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
			<tr>
				<th> 거리(km) </th>
				<th> 관리번호 </th>
				<th> 자치구 </th>
				<th> 와이파이명 </th>
				<th> 도로명주소 </th>
				<th> 상세주소 </th>
				<th> 설치위치(층) </th>
				<th> 설치유형 </th>
				<th> 설치기관 </th>
				<th> 서비스구분 </th>
				<th> 망종류 </th>
				<th> 설치년도 </th>
				<th> 실내외구분 </th>
				<th> WIFI접속환경</th>
				<th> X좌표 </th>
				<th> Y좌표 </th>
				<th> 작업일자 </th>			
			</tr>
		</thead>
		<tbody>
		
			<!-- lat, lnt값이 없다면 위치정보를 입력하지 않은것으로 간주합니다. -->
			<%
				if (latParam == null && lntParam == null) {
			%>		
				<tr>
					<td colspan="17" style="font-size: 24px; font-weight: bold; text-align: center;">위치정보를 입력한 후에 조회해주세요</td>
				</tr>			
			<%
				} else {					
				boolean isWhiteRow = true;
				int count = 0;
				for(Member member : wifi_List) {
					if(count >= 20) break;
					count++;
					String rowColor = isWhiteRow ? "white" : "#F2F2F2";					
			%>	
			<%
				if(wifi_List.isEmpty()){
			%>		

			<%
				}
			%>
				<tr style="background-color: <%=rowColor%>;">
					<td><%=member.getDistance()%></td>
					<td><%=member.getMan_num()%></td>
					<td><%=member.getBorough()%></td>
					<td><a href="detail_wifi.jsp?wifi_name=<%=member.getWifi_name()%>"><%=member.getWifi_name()%></a></td>
					<td><%=member.getRoad_num()%></td>
					<td><%=member.getDetail_addr()%></td>
					<td></td>
					<td><%=member.getIns_type()%></td>
					<td><%=member.getIns_age()%></td>
					<td><%=member.getService()%></td>					
					<td><%=member.getNetwork()%></td>
					<td><%=member.getIns_year()%></td>
					<td><%=member.getIn_out()%></td>
					<td></td>
					<td><%=member.getX_coor()%></td>
					<td><%=member.getY_coor()%></td>
					<td><%=member.getWork_date()%></td>
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