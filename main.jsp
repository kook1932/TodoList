<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.connect.TodoList.dto.TodoDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<title>Todo-List</title>
<link rel="stylesheet" href="main.css?after">
</head>
<body>
	
<header>
  <button class="new" 
  onclick="location.href='http://localhost:8080/TodoList/TodoFromServlet'">
  할일 등록</button>
</header>

<section id = "sec-body">
  
  <section id = "left" class="com" style="width:100px">
  </section>

  <!-- TODO Type 할 일 목록 출력 -->
  <section id = "todo" class="com">
    <p class="title">TODO</p>
    <!-- MainServlet에서 전송한 dtoList forEach를 통해 반복 -->
    <c:forEach var="todo" items="${dtoList}">
		<c:if test="${todo.getType() eq 'TODO'}">
		    <section class="content">
		      <p class="content-title">
		        ${todo.getTitle() }
		      </p>
		      <p class="content-data">등록날짜 : ${todo.getRegDate() }, ${todo.getName() } 우선순위 : ${todo.getSequence() }</p>
		      <c:set var="vid1" scope="request" value="${todo.getId() }"/>
		      <!-- 화살표를 누르면 Type을 변경하는 next 함수가 실행됨 -->
		      <!-- 버튼의 id를 튜플의 id로 설정함 -->
		      <button id=${vid1 } class="nextType" onclick="next(id)">-></button>
		    </section>
		</c:if>
  	</c:forEach>
  </section>
  
  <section id = "doing" class="com">
    <p class="title"> DOING</p>
        <c:forEach var="todo" items="${dtoList}">
		<c:if test="${todo.getType() eq 'DOING'}">
		    <section class="content">
		      <p class="content-title">
		        ${todo.getTitle() }
		      </p>
		      <p class="content-data">등록날짜 : ${todo.getRegDate() }, ${todo.getName() } 우선순위 : ${todo.getSequence() }</p>
		      <c:set var="vid2" scope="request" value="${todo.getId() }"/>
		      <button id=${vid2 } class="nextType" onclick="next(id)">-></button>
		    </section>
		</c:if>
  		</c:forEach>
  </section>
  
  <section id = "done" class="com">
    <p class="title"> DONE</p>
        <c:forEach var="todo" items="${dtoList}">
		<c:if test="${todo.getType() eq 'DONE'}">
		    <section class="content">
		      <p class="content-title">
		        ${todo.getTitle() }
		      </p>
		      <p class="content-data">등록날짜 : ${todo.getRegDate() }, ${todo.getName() } 우선순위 : ${todo.getSequence() }</p>
		      <c:set var="vid3" scope="request" value="${todo.getId() }"/>
		      <!-- X 버튼을 클릭하면 할 일 삭제 -->
		      <button id=${vid3 } class="nextType" onclick="buttonDelete(id)">X</button>
		    </section>
		</c:if>
  		</c:forEach>
  </section>
  
</section>
  
</body>

<script type="text/javascript">
	// TODO -> DOING, DOING -> DONE으로 타입을 변환시키는 함수
	// AJAX 방식으로 구현하여 새로고침 없이 구현하려고 했지만 아직 미구현
	// AJAX를 더 공부하여 구현할 예정
	function next(bid){
		var oReq = new XMLHttpRequest();
		oReq.addEventListener("load", function() {
			window.location.reload();
		});
		oReq.open("GET", "http://localhost:8080/TodoList/TodoTypeServlet?id=" + bid); 
		oReq.send();
	}
	
	function buttonDelete(bid){
		var oReq = new XMLHttpRequest();
		oReq.addEventListener("load", function() {
			window.location.reload();
		});
		oReq.open("GET", "http://localhost:8080/TodoList/TodoDeleteServlet?id=" + bid); 
		oReq.send();
	}
	
</script>
</html>