package kr.or.connect.TodoList.main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.connect.TodoList.dao.TodoDao;

/**
 * Servlet implementation class TodoTypeServlet
 */
@WebServlet("/TodoTypeServlet")
public class TodoTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TodoTypeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TodoDao dao  = new TodoDao();
		// main.jsp에서 GET 방식으로 넘어온 id 정보를 받아서
		// id에 해당하는 type을 변경한다.
		Long id = Long.parseLong(request.getParameter("id"));
		dao.updateTodo(id);
	}

}
