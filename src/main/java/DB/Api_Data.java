package DB;

import okhttp3.*;
import kotlin.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import javax.servlet.http.HttpServletRequest;

//APi에서 APi데이터를 가져와서 DB에 저장하는 코드

public class Api_Data {
    public static void api_data(HttpServletRequest request) {
        // SQLite 드라이버 로드
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        }
        // SQLite 연결 설정
        try {
            Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\dev\\sqlite-tools-win32-x86-3420000\\sqlite-tools-win32-x86-3420000\\WIFI.sqlite3\\");
            // 테이블 생성
            String createTableQuery = "DROP TABLE IF EXISTS WIFI_API_DATA;";
            PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery);
            createTableStatement.executeUpdate();
            createTableStatement.close();
            
            createTableQuery = "CREATE TABLE IF NOT EXISTS WIFI_API_DATA (distance FLOAT,man_num TEXT, borough TEXT, wifi_name TEXT, road_num TEXT, detail_addr TEXT, ins_type TEXT, ins_age TEXT, service TEXT, network TEXT, ins_year TEXT, in_out TEXT, x_coor FLOAT, y_coor FLOAT, work_date TEXT);";
            createTableStatement = connection.prepareStatement(createTableQuery);
            createTableStatement.executeUpdate();
            createTableStatement.close();
            
            //데이터 가져올 api 주소, okhttp3사용
            OkHttpClient client = new OkHttpClient();
            Gson gson = new Gson();
            String baseUrl = "http://openapi.seoul.go.kr:8088/466f6a6841736b643637664d65626a/json/TbPublicWifiInfo/";
            int start = 1;
            int end = 1000;
            
            
            // 공공 API에서 데이터 가져오기
            String url = baseUrl + start + "/" + end + "/";
            Request request2 = new Request.Builder()
                    .url(url)
                    .build();
            Response apiResponse = client.newCall(request2).execute();
            String responseStr = apiResponse.body().string();
            // JSON 데이터 파싱
            JsonObject json = gson.fromJson(responseStr, JsonObject.class);
            JsonObject tbPublicWifiInfo = json.getAsJsonObject("TbPublicWifiInfo");
            JsonArray rows = json.getAsJsonObject("TbPublicWifiInfo").getAsJsonArray("row");
            int endNum = Integer.parseInt(tbPublicWifiInfo.get("list_total_count").getAsString());
            endNum = endNum/end +1;
            
            //
            for (int i = 0; i < endNum; i++) {
                // SQLite 데이터베이스에 데이터 저장
                String insertQuery = "INSERT INTO WIFI_API_DATA (distance,man_num, borough, wifi_name, road_num, detail_addr, ins_type, ins_age, service, network, ins_year, in_out, x_coor, y_coor, work_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(insertQuery);
                
                for (int j = 0; j < rows.size(); j++) {
                    JsonObject row = rows.get(j).getAsJsonObject();
                    statement.setFloat(1, 0); // distance
                    statement.setString(2, row.get("X_SWIFI_MGR_NO").getAsString()); // man_num
                    statement.setString(3, row.get("X_SWIFI_WRDOFC").getAsString()); // borough
                    statement.setString(4, row.get("X_SWIFI_MAIN_NM").getAsString()); // wifi_name
                    statement.setString(5, row.get("X_SWIFI_ADRES1").getAsString()); // road_num
                    statement.setString(6, row.get("X_SWIFI_ADRES2").getAsString()); // detail_addr
                    statement.setString(7, row.get("X_SWIFI_INSTL_TY").getAsString()); // ins_type
                    statement.setString(8, row.get("X_SWIFI_INSTL_MBY").getAsString()); //ins_age
                    statement.setString(9, row.get("X_SWIFI_SVC_SE").getAsString()); // service
                    statement.setString(10, row.get("X_SWIFI_CMCWR").getAsString()); // network
                    statement.setString(11, row.get("X_SWIFI_CNSTC_YEAR").getAsString()); // ins_year
                    statement.setString(12, row.get("X_SWIFI_INOUT_DOOR").getAsString()); // in_out
                    statement.setFloat(13, Float.parseFloat(row.get("LAT").getAsString())); // x_coor
                    statement.setFloat(14, Float.parseFloat(row.get("LNT").getAsString())); // y_coor
                    statement.setString(15, row.get("WORK_DTTM").getAsString()); // work_date
                    statement.executeUpdate();
                }
                
                // 작업 완료 후 연결 종료
                statement.close();
                apiResponse.close();
                
            	
                // 다음 범위를 위해 start와 end 값 조정
                if(i == (endNum -1)) {                    
                    start += 1000;
                    end = Integer.parseInt(tbPublicWifiInfo.get("list_total_count").getAsString());
                    request.setAttribute("endValue", end);
                }else {
                    start += 1000;
                    end += 1000;
                }

            }
            //같은 man_num을 가진 데이터를 삭제하는 부분 > 중복데이터가 DB안에 많아서 근처WIFI검색시 같은 와이파이가 20개 잡히는 경우 
            String deleteDuplicateQuery = "DELETE FROM WIFI_API_DATA WHERE rowid NOT IN (SELECT MIN(rowid) FROM WIFI_API_DATA GROUP BY man_num)";
            PreparedStatement deleteDuplicateStatement = connection.prepareStatement(deleteDuplicateQuery);
            deleteDuplicateStatement.executeUpdate();
            deleteDuplicateStatement.close();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
