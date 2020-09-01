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
  <button class="new" onclick="location.href='http://localhost:8080/TodoList/TodoFormServlet'">할일 등록</button>
</header>

<section id = "sec-body">
  <!-- 왼쪽 여백 -->
  <section id = "left" class="com" style="width:100px"></section>

  <!-- Type이 "TODO"인 할 일 목록만 출력 -->
  <section id = "TODO" class="com">
    <p class="title">TODO</p>
    <c:forEach var="todo" items="${dtoList}">
		<c:if test="${todo.getType() eq 'TODO'}">
		    <section class="content">
		      <p class="content-title">${todo.getTitle() }</p>
		      <p class="content-data">등록날짜 : ${todo.getRegDate() }, ${todo.getName() } 우선순위 : ${todo.getSequence() }</p>
		      <!-- button의 id를 할 일의 id와 type으로 설정함 -->
		      <button id="${todo.getId()}#${todo.getType()}" class="nextType" onclick="next(id)">-></button>
		    </section>
		</c:if>
  	</c:forEach>
  </section>
  
  <!-- Type이 "DOING"인 할 일 목록만 출력 -->
  <section id = "DOING" class="com">
    <p class="title">DOING</p>
        <c:forEach var="todo" items="${dtoList}">
		<c:if test="${todo.getType() eq 'DOING'}">
		    <section class="content">
		      <p class="content-title">${todo.getTitle() }</p>
		      <p class="content-data">등록날짜 : ${todo.getRegDate() }, ${todo.getName() } 우선순위 : ${todo.getSequence() }</p>
		      <button id="${todo.getId()}#${todo.getType()}" class="nextType" onclick="next(id)">-></button>
		    </section>
		</c:if>
  		</c:forEach>
  </section>
  
  <!-- Type이 "DONE"인 할 일 목록만 출력 -->
  <section id = "DONE" class="com">
    <p class="title">DONE</p>
        <c:forEach var="todo" items="${dtoList}">
		<c:if test="${todo.getType() eq 'DONE'}">
		    <section class="content">
		      <p class="content-title">${todo.getTitle() }</p>
		      <p class="content-data">등록날짜 : ${todo.getRegDate() }, ${todo.getName() } 우선순위 : ${todo.getSequence() }</p>
		      <c:set var="vid3" scope="request" value="${todo.getId() }"/>
		      <button id="${todo.getId()}#${todo.getType()}" class="nextType" onclick="buttonDelete(id)">X</button>
		    </section>
		</c:if>
  		</c:forEach>
  </section>
  
</section>
  
</body>

<script type="text/javascript" src="./main.js?v=<%=System.currentTimeMillis() %>"></script>
</html>