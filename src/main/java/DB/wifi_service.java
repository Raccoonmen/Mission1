package DB;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;


public class wifi_service {
    private static final double EARTH_RADIUS = 6371.0;

    public List<Member> near_wifi(float lat, float lnt) {
            
    
        List<Member> memberList = new ArrayList<>();
        
        //MemberService 
        
        
        //5개
        //1. ip(도메인주소)
        //2. port
        //3. 계정
        //4. password
        //5. 인스턴스


        //1. 드라이브 로드
        //2. 커넥션 객체생성
        //3. 스테이트먼트 객체 생성
        //4. 쿼리실행
        //5. 결과수행
        //6. 객체연결 해제

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        PreparedStatement preparedStatement2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;

        //1. 드라이브 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            String sql = "SELECT distance, man_num, borough, wifi_name, road_num, detail_addr, ins_type, ins_age, service, network, ins_year, in_out, x_coor, y_coor, work_date " +
                    "FROM WIFI_API_DATA ";

            preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();

            while (rs.next()) { //DB에 현재위치와의 거리 distance를 업데이트하면서 리스트 만들기. 
                float distance = (float) getDistance(lat, lnt, rs.getDouble("x_coor"), rs.getDouble("y_coor"));
                updateDistance(connection, rs.getString("man_num"), distance);
            }
            
            String sql2 = "SELECT distance, man_num, borough, wifi_name, road_num, detail_addr, ins_type, ins_age, service, network, ins_year, in_out, x_coor, y_coor, work_date " +
            	    "FROM WIFI_API_DATA " +
            	    "ORDER BY distance ASC";

            preparedStatement2 = connection.prepareStatement(sql2);
            rs2 = preparedStatement2.executeQuery();
            
            while(rs2.next()) { //리스트 만들기. 
                Member member = new Member();
                member.setDistance(rs2.getFloat("distance"));
                member.setMan_num(rs2.getString("man_num"));
                member.setBorough(rs2.getString("borough"));
                member.setWifi_name(rs2.getString("wifi_name"));
                member.setRoad_num(rs2.getString("road_num"));
                member.setDetail_addr(rs2.getString("detail_addr"));
                member.setIns_type(rs2.getString("ins_type"));
                member.setIns_age(rs2.getString("ins_age"));
                member.setService(rs2.getString("service"));
                member.setNetwork(rs2.getString("network"));
                member.setIns_year(rs2.getString("ins_year"));
                member.setIn_out(rs2.getString("in_out"));
                member.setX_coor(rs2.getFloat("x_coor"));
                member.setY_coor(rs2.getFloat("y_coor"));
                member.setWork_date(rs2.getString("work_date"));

                memberList.add(member);
            }
           

            Collections.sort(memberList, Comparator.comparing(Member::getDistance));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null && !rs.isClosed()) {
                    rs.close();
                }
                if (preparedStatement != null && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
                if (rs2 != null && !rs2.isClosed()) {
                    rs2.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return memberList;
    }
    
    // 두 지점 사이의 거리 계산 메소드
    private double getDistance(double lat1, double lon1, double lat2, double lon2) {
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);

        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double d = EARTH_RADIUS * c;  // 거리를 킬로미터(km)로 표시
        return d;
    }

    // 거리 업데이트 메소드
    private void updateDistance(Connection connection, String manNum, float distance) {
        PreparedStatement preparedStatement = null;

        try {
            String sql = "UPDATE WIFI_API_DATA SET distance = ? WHERE man_num = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, distance);
            preparedStatement.setString(2, manNum);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
       
    public List<Member> detail(String wifiName) {
    	
    	List<Member> memberList = new ArrayList<>();
    	

        //5개
        //1. ip(도메인주소)
        //2. port
        //3. 계정
        //4. password
        //5. 인스턴스


        //1. 드라이브 로드
        //2. 커넥션 객체생성
        //3. 스테이트먼트 객체 생성
        //4. 쿼리실행
        //5. 결과수행
        //6. 객체연결 해제

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        //1. 드라이브 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e ){
        }



        //2~3. 커넥션, 스테티으먼트 객체 생성
        try {
        	connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");


            String sql = "SELECT distance, man_num, borough, wifi_name, road_num, detail_addr, ins_type, ins_age, service, network, ins_year, in_out, x_coor, y_coor, work_date " +
                    "FROM WIFI_API_DATA " +
                    "WHERE wifi_name = ?"; 

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, wifiName);

            //4. 쿼리실행
            rs = preparedStatement.executeQuery();

            //5. 결과수행
            while (rs.next()) {     
                Member member = new Member();
                member.setDistance(rs.getFloat("distance"));
                member.setMan_num(rs.getString("man_num"));
                member.setBorough(rs.getString("borough"));
                member.setWifi_name(rs.getString("wifi_name"));
                member.setRoad_num(rs.getString("road_num"));
                member.setDetail_addr(rs.getString("detail_addr"));
                member.setIns_type(rs.getString("ins_type"));
                member.setIns_age(rs.getString("ins_age"));
                member.setService(rs.getString("service"));
                member.setNetwork(rs.getString("network"));
                member.setIns_year(rs.getString("ins_year"));
                member.setIn_out(rs.getString("in_out"));
                member.setX_coor(rs.getFloat("x_coor"));
                member.setY_coor(rs.getFloat("y_coor"));
                member.setWork_date(rs.getString("work_date"));

                memberList.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null && !rs.isClosed()) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (preparedStatement != null && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return memberList;
    }
    
}