package kr.or.connect.TodoList.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import kr.or.connect.TodoList.dto.TodoDto;

public class TodoDao {
	// DB 연결을 위한 URL, User, Password 정보는 private로 제한한다.
	// 또한 자주 사용되므로 String으로 생성하고 사용한다.
	
	private static String dburl = "jdbc:mysql://localhost:3306/connectdb?serverTimezone=Asia/Seoul&useSSL=false";
	private static String dbuser = "connectuser";
	private static String dbpw = "connect123!@#";
	
	public int addTodo(TodoDto td) {
		int cnt = 0;
		
		// id, type, date는 자동으로 생성되므로 입력하지 않아도 된다.
		String sql = "insert into todo(title, name, sequence) values(?,?,?);";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// 가독성을 위해 try-with-resource 구문 활용
		try(Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
				PreparedStatement ps = conn.prepareStatement(sql);){
			ps.setString(1, td.getTitle());
			ps.setString(2, td.getName());
			ps.setInt(3, td.getSequence());
			cnt = ps.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	// Table에 있는 모든 튜플 불러오는 함수
	public List<TodoDto> getTodos(){
		List<TodoDto> list = new ArrayList<TodoDto>();
		String sql = "select * from todo";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// 가독성을 위해 try-with-resource 구문 활용
		try(Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
				PreparedStatement ps = conn.prepareStatement(sql)){
			try(ResultSet rs = ps.executeQuery();) {
				while(rs.next()) {
					Long id = rs.getLong(1);
					String title = rs.getString(2);
					String name = rs.getString(3);
					int sequence = rs.getInt(4);
					String type = rs.getString(5);
					// Date 정보가 yyyy-mm-dd HH:MM:SS 형식으로 저장되어있음.
					// 날짜만 얻고 싶기 때문에 간단하게 substring 함수로 시분초는 자름.
					String regDate = rs.getString(6).substring(0, 10);
					TodoDto dto = new TodoDto(id, title, name, sequence, type, regDate);
					list.add(dto);
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 할 일의 Type을 변경하기 위한 함수
	// TODO -> DOING, DOING -> DONE
	public int updateTodo(Long todo_id) {
		int cnt = 0;
		String sql1 = "update todo set type = 'DONE' where type = 'DOING' and id = ?;";
		String sql2 = "update todo set type = 'DOING' where type = 'TODO' and id = ?;";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// DOING -> DONE
		try(Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
				PreparedStatement ps = conn.prepareStatement(sql1);){
			ps.setLong(1, todo_id);
			cnt = ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// TODO -> DOING
		try(Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
				PreparedStatement ps = conn.prepareStatement(sql2);){
			ps.setLong(1, todo_id);
			cnt = ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	// 완료한 할 일을 삭제하는 함수
	public int deleteTodo(Long id) {
		int cnt=0;
		String sql = "delete from todo where id=?;";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		try(Connection conn = DriverManager.getConnection(dburl,dbuser,dbpw);
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
}
