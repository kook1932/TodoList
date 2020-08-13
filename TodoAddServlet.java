package kr.or.connect.TodoList.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.connect.TodoList.dao.TodoDao;
import kr.or.connect.TodoList.dto.TodoDto;

/**
 * Servlet implementation class TodoAddServlet
 */
@WebServlet("/TodoAddServlet")
public class TodoAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TodoAddServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// getParameter 함수를 통해 todoForm.jsp에서 POST 방식으로 전송된 데이터를 추출한다.
		String title = (String)request.getParameter("title");
		String name = (String)request.getParameter("name");
		int seq = Integer.parseInt(request.getParameter("sequence"));
		TodoDao dao = new TodoDao();
		TodoDto dto = new TodoDto(title,name,seq);
		
		// Table에 새로운 할 일 추가
		dao.addTodo(dto);
	    response.sendRedirect("MainServlet");
	}

}
