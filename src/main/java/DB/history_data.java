package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class history_data {
	
	
    public List<Member> history() {
    	
    	List<Member> memberList = new ArrayList<>();
    	

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


            String sql = " select id,h_x_coor ,h_y_coor,check_date " +
            		 "from WIFI_HISTORY";


            preparedStatement = connection.prepareStatement(sql);

            //4. 쿼리실행
            rs = preparedStatement.executeQuery();

            //5. 결과수행
            while (rs.next()) {     
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setH_x_coor(rs.getFloat("h_x_coor"));
                member.setH_y_coor(rs.getFloat("h_y_coor"));
                member.setCheck_date(rs.getString("check_date"));           
                memberList.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 6. 객체 닫기
            try {
                if(rs != null && !rs.isClosed()) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(preparedStatement != null && !preparedStatement.isClosed()){
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(rs != null && !connection.isClosed()){
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return memberList;
    }
	
    public void store_data(float lat, float lnt) {
        // SQLite 드라이버 로드
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        }
        
        Connection connection = null;
        PreparedStatement createTableStatement = null;
        PreparedStatement insertStatement = null;
        ResultSet resultSet = null;

        try {
            // SQLite 연결 설정
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");
            connection.setAutoCommit(false);

            // 테이블 생성
            String createTableQuery = "CREATE TABLE IF NOT EXISTS WIFI_HISTORY (id INTEGER PRIMARY KEY AUTOINCREMENT, h_x_coor FLOAT, h_y_coor FLOAT, check_date TEXT);";
            createTableStatement = connection.prepareStatement(createTableQuery);
            createTableStatement.executeUpdate();
            createTableStatement.close();

            // 테이블의 마지막 ID 값 가져오기
            String lastIdQuery = "SELECT MAX(id) FROM WIFI_HISTORY;";
            PreparedStatement lastIdStatement = connection.prepareStatement(lastIdQuery);
            resultSet = lastIdStatement.executeQuery();
            int lastId = resultSet.getInt(1);
            lastIdStatement.close();

            // SQLite 데이터베이스에 데이터 저장
            String insertQuery = "INSERT INTO WIFI_HISTORY (id, h_x_coor, h_y_coor, check_date) VALUES (?, ?, ?, ?)";
            insertStatement = connection.prepareStatement(insertQuery);

            // ID 값 설정
            int newId = lastId + 1;
            insertStatement.setInt(1, newId);

            insertStatement.setFloat(2, lat); // x_coor
            insertStatement.setFloat(3, lnt); // y_coor
            insertStatement.setString(4, String.valueOf(new Timestamp(System.currentTimeMillis()))); // check_date

            insertStatement.executeUpdate();
            connection.commit();

            // 작업 완료 후 연결 종료
            insertStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();

            // 롤백 처리
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            // 객체 닫기
            try {
                if (resultSet != null && !resultSet.isClosed()) {
                    resultSet.close();
                }
                if (createTableStatement != null && !createTableStatement.isClosed()) {
                    createTableStatement.close();
                }
                if (insertStatement != null && !insertStatement.isClosed()) {
                    insertStatement.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public void deleteData(Integer id) {
        Connection connection = null;
        PreparedStatement deleteStatement = null;
        PreparedStatement updateStatement = null;

        try {
            // 1. 드라이버 로드
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");

            // 2. 커넥션 객체 생성
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            // 3. SQL 쿼리 작성 - 삭제
            String deleteSql = "DELETE FROM WIFI_HISTORY WHERE id = ?";
            deleteStatement = connection.prepareStatement(deleteSql);
            deleteStatement.setInt(1, id);
            deleteStatement.executeUpdate();

            // 4. SQL 쿼리 작성 - ID 업데이트
            String updateSql = "UPDATE WIFI_HISTORY SET id = id - 1 WHERE id > ?";
            updateStatement = connection.prepareStatement(updateSql);
            updateStatement.setInt(1, id);
            updateStatement.executeUpdate();

            System.out.println("ID " + id + "의 데이터가 삭제되었습니다.");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // 5. 객체 닫기
            try {
                if (deleteStatement != null && !deleteStatement.isClosed()) {
                    deleteStatement.close();
                }
                if (updateStatement != null && !updateStatement.isClosed()) {
                    updateStatement.close();
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
    }
}