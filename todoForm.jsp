<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<title>할 일 등록</title>
<link rel="stylesheet" href="todoForm.css?after">
</head>

<body>
<div>
  <p><h1 style="text-align:center;">할 일 등록</h1></p>
  <section>
  <!-- form에 입력받은 정보를 TodoAddServlet에게 POST 방식으로 전송한다-->
    <form action="http://localhost:8080/TodoList/TodoAddServlet" method="post">
      <div class="input">
      <!-- label과 input의 name을 꼭 지정해준다. -->
        <label for="title" class="content">어떤 일인가요?</label><br>
        <input type="text" class="content" name = "title" placeholder="java공부하기" size=40 maxlength=24><br>
      </div>

      <div class="input">
        <label for="name" class="content">누가 할 일인가요?</label><br>
        <input type="text" class="content" name = "name" placeholder="홍길동"><br>
      </div>

      <div class="input">
      <!-- radio가 여러개일 경우 같은 name으로 정하면 선택된 radio의 value만 전송할 수 있다. -->
        <label for="seqeunce" class="content">우선순위를 선택하세요</label><br>
        <input type="radio" class="content" name = "sequence" value=1 checked>1위
        <input type="radio" class="content" name = "sequence" value=2>2위
        <input type="radio" class="content" name = "sequence" value=3>3위<br>
      </div>

      <div class="input">
        <input type="reset" class="form-btn" value="내용 지우기">
		<input type="submit" class="form-btn" value="제출">
      </div>
      
    </form>
    
    <div class="input">
      <button id="back" onclick="location.href='http://localhost:8080/TodoList/MainServlet' ">이전</button>
    </div>
      
  </section>
  
</div>
</body>
</html>