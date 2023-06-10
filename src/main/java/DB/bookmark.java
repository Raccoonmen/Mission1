package DB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;


//북마크 관련 메서드들이 담긴 클래스
public class bookmark {
	
	//북마크 그룹을 추가하는 메서드,테이블이 없다면 만들어냄, bookmark_add.jsp에서 사용
	public void bookmark_group(String bookmark_name, Integer order_num) {
	    Connection connection = null;
	    PreparedStatement createTableStatement = null;
	    PreparedStatement insertStatement = null;

	    try {
	        Class.forName("org.sqlite.JDBC");
	        System.out.println("SQLite DB 연결");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    try {
	        connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

	        //"BOOKMARK"라는 테이블을 만들고 컬럼을 만든다. id는 1씩 점차 증가함. 
	        String createTableQuery = "CREATE TABLE IF NOT EXISTS BOOKMARK (id INTEGER PRIMARY KEY AUTOINCREMENT, bookmark_name TEXT, order_num INTEGER, regi_date TEXT, modi_date TEXT);";
	        createTableStatement = connection.prepareStatement(createTableQuery);
	        createTableStatement.executeUpdate();
	        createTableStatement.close();

	        // AUTOINCREMENT 초기화 > sqlite_sequence 테이블에서 "BOOKMARK" 테이블의 AUTOINCREMENT 값을 초기화해서 테이블에 데이터가 없으면 id가 다시 1부터 시작.
	        String resetAutoIncrementQuery = "DELETE FROM sqlite_sequence WHERE name = 'BOOKMARK'";
	        insertStatement = connection.prepareStatement(resetAutoIncrementQuery);
	        insertStatement.executeUpdate();
	        insertStatement.close();

	        //받아온 북마크 이름, 순서번호로 "BOOKMARK"에 추가함 regi_date에는 현재 시간을 넣는다.
	        String insertQuery = "INSERT INTO BOOKMARK (bookmark_name, order_num, regi_date) VALUES (?, ?, datetime('now'))";
	        insertStatement = connection.prepareStatement(insertQuery);
	        insertStatement.setString(1, bookmark_name);
	        insertStatement.setInt(2, order_num);
	        insertStatement.executeUpdate();
	        insertStatement.close();
	        
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
            try {
                if (insertStatement != null && !insertStatement.isClosed()) {
                    insertStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (createTableStatement != null && !createTableStatement.isClosed()) {
                    createTableStatement.close();
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



	//북마크 그룹을 리스트로서 나타내는 메서드, bookmark_group.jsp에서 사용
    public List<Member> bookmark_group_list() {

        List<Member> memberList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        //드라이브 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e ){
        }



        //커넥션, 스테이트먼트 객체 생성
        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");
            String sql = " select id, bookmark_name , order_num ,regi_date,modi_date " +
                    "from BOOKMARK";
            preparedStatement = connection.prepareStatement(sql);

            //쿼리실행
            rs = preparedStatement.executeQuery();

            //결과수행
            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setBookmark_name(rs.getString("bookmark_name"));
                member.setOrder_num(rs.getInt("order_num"));
                member.setRegi_date(rs.getString("regi_date"));
                member.setModi_date(rs.getString("modi_date"));
                memberList.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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
    
    //북마크 그룹을 수정하는 폼에서 기존에 저장되어 있는 데이터를 표현하기 위한 메서드, update_bookmark_group.jsp에서 사용
    public List<Member> bookmark_group_update_list(String regi_date) {

        List<Member> memberList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        //드라이버 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        //커넥션, 스테이트먼트 객체 생성
        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            //쿼리 작성
            String sql = "SELECT id, bookmark_name, order_num FROM BOOKMARK WHERE regi_date = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, regi_date);

            //쿼리 실행
            rs = preparedStatement.executeQuery();

            //결과 수행
            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setBookmark_name(rs.getString("bookmark_name"));
                member.setOrder_num(rs.getInt("order_num"));
                memberList.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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
    

    public void bookmark_group_update(Integer Id, String bookmark_name, Integer order_num, String regi_date) {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        //드라이버 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        //커넥션, 스테이트먼트 객체 생성
        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            //업데이트 쿼리 작성
            String sql = "UPDATE BOOKMARK SET id = ?, bookmark_name = ?, order_num = ?, modi_date = ? WHERE regi_date = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Id);
            preparedStatement.setString(2, bookmark_name);
            preparedStatement.setInt(3, order_num);            
            //현재 시간을 modi_date에 추가
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String modiDateString = sdf.format(new Date());
            preparedStatement.setString(4, modiDateString);           
            preparedStatement.setString(5, regi_date);

            //쿼리 실행
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                System.out.println("업데이트 성공");
            } else {
                System.out.println("업데이트 실패");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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
    }
    
    
    //와이파이 상세보기에서 select.option을 나타내기 위한 메서드, detail_wifi.jsp에서 사용. 북마크 그룹의 이름만을 가져감
    public List<Member> bookmark_group_name() {

        List<Member> memberList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        //드라이브 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e ){
        }



        //커넥션, 스테이트먼트 객체 생성
        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");
            String sql = " select id, bookmark_name " +
                    "from BOOKMARK";
            preparedStatement = connection.prepareStatement(sql);

            //쿼리실행
            rs = preparedStatement.executeQuery();

            //결과수행
            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setBookmark_name(rs.getString("bookmark_name"));
                memberList.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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


    //북마크를 실질적으로 추가하는데 사용하는 메서드. bookmark_add.jsp에서 사용
    public void add_bookmark(Integer id, String bookmark_name, String wifiName) {


        Connection connection = null;
        PreparedStatement createTableStatement = null;

        PreparedStatement insertStatement = null;

        //드라이브 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            String createTableQuery = "CREATE TABLE IF NOT EXISTS BOOKMARK_STORE (id INTEGER, bookmark_name TEXT, wifi_name TEXT, regi_date TEXT);";
            createTableStatement = connection.prepareStatement(createTableQuery);
            createTableStatement.executeUpdate();
            createTableStatement.close();


            String insertQuery = "INSERT INTO BOOKMARK_STORE (id, bookmark_name, wifi_name, regi_date) VALUES (?, ?, ?, ?)";
            insertStatement = connection.prepareStatement(insertQuery);
            insertStatement.setInt(1, id);
            insertStatement.setString(2, bookmark_name);
            insertStatement.setString(3, wifiName);

            //현재 시간을 가져와서 포맷팅
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentTime = dateFormat.format(new Date());

            insertStatement.setString(4, currentTime);

            insertStatement.executeUpdate();
            insertStatement.close();
            
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
            try {
                if (createTableStatement != null && !createTableStatement.isClosed()) {
                    createTableStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (insertStatement != null && !insertStatement.isClosed()) {
                    insertStatement.close();
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


    //북마크 리스트. 북마크를 보여주기 위한 메서드 bookmark.jsp에서 사용
    public List<Member> bookmark_list() {

        List<Member> memberList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        //드라이브 로드
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");
        } catch (ClassNotFoundException e ){
        }



        //커넥션, 스테이트먼트 객체 생성
        try {
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");


            String sql = " select id, bookmark_name , wifi_name ,regi_date " +
                    "from BOOKMARK_STORE";


            preparedStatement = connection.prepareStatement(sql);

            //쿼리실행
            rs = preparedStatement.executeQuery();

            //결과수행
            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setBookmark_name(rs.getString("bookmark_name"));
                member.setWifi_name(rs.getString("wifi_name"));
                member.setRegi_date(rs.getString("regi_date"));
                memberList.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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
    
    
    
    //북마크를 지우기 위한 메서드, delete_bookmark_part.jsp에서 사용
    public void delete_Bookmark_Part(String regi_date) {
        Connection connection = null;
        PreparedStatement deleteStatement = null;
        PreparedStatement updateStatement = null;

        try {
            //드라이버 로드
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");

            //커넥션 객체 생성
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            //SQL 쿼리 작성 - 삭제
            String deleteSql = "DELETE FROM BOOKMARK_STORE WHERE regi_date = ?";
            deleteStatement = connection.prepareStatement(deleteSql);
            deleteStatement.setString(1, regi_date);
            deleteStatement.executeUpdate();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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
    
    
    //북마크 그룹을 지우기 위한 메서드. delete_bookmark.jsp에서 사용
    public void delete_Bookmark_Group(String regi_date) {
        Connection connection = null;
        PreparedStatement deleteStatement = null;
        PreparedStatement updateStatement = null;

        try {
            //드라이버 로드
            Class.forName("org.sqlite.JDBC");
            System.out.println("SQLite DB 연결");

            //커넥션 객체 생성
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");

            //SQL 쿼리 작성 - 삭제
            String deleteSql = "DELETE FROM BOOKMARK WHERE regi_date = ?";
            deleteStatement = connection.prepareStatement(deleteSql);
            deleteStatement.setString(1, regi_date);
            deleteStatement.executeUpdate();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            //객체 닫기
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
