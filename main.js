function next(bid){
	// button id = id#type을 #으로 split하여 할 일의 id와 type을 추출한다.
	var buttonInfo = bid.split('#');
    var type = buttonInfo[1];
    var id = buttonInfo[0];
    
    // 클라이언트와 서버의 비동기 통신(Ajax)를 위해 XMLHttpRequest 객체를 생성한다.
	var oReq = new XMLHttpRequest();
	
	// XMLHttpRequest의 이벤트 리스너에 콜백 함수를 구현하여 스택에 있는 함수들이 모두 실행된 후
	// 가장 마지막에 실행되도록 한다.
	oReq.addEventListener("load", function() {
		// request가 끝나고 response가 준비된 상태일 때 콜백 함수를 실행시키기 위해 조건문을 추가한다.
		if (oReq.readyState === XMLHttpRequest.DONE) {
			// status 프로퍼티는 서버의 문서 상태를 나타낸다.
			// status가 200이면 서버에 문서가 존재함을 나타낸다.
			if (oReq.status === 200){
				// Type이 변경된 할 일은 삭제한다.
				var targetButton = document.getElementById(bid);
				var target = targetButton.parentElement;
				var targetParent = target.parentElement;
				
				targetParent.removeChild(target);
				
				// TodoTypeServlet에서 변경된 할 일 목록을 받음
				var json = this.responseText;
				json = JSON.parse(json);
				
				// 변경된 데이터(json)로 HTML을 업로드 함.
				var newSection = null;
				var msg = "";
				for(value in json){
					var todo = json[value];
					var type = todo['type'];
					
					newSection = document.getElementById(type);
					newSection.innerHTML = "<p class='title'>" + type + "</p>";
					
					if(type === "DOING"){
						msg += "<section class='content'>" + 
						"<p class='content-title'>" + todo['title'] + "</p>" + 
						"<p class='content-data'>" + "등록날짜 : " + todo['regDate'] +", "+ todo['name'] + " 우선순위 : " + todo['sequence'] + "</p>" + 
						"<button id=" + "'" + todo['id'] + "#" + todo['type'] + "'"+ "class='nextType' onclick='next(id)'>-></button>" + 
						"</section>";
					}
					else{
						msg += "<section class='content'>" + 
						"<p class='content-title'>" + todo['title'] + "</p>" + 
						"<p class='content-data'>" + "등록날짜 : " + todo['regDate'] +", "+ todo['name'] + " 우선순위 : " + todo['sequence'] + "</p>" + 
						"<button id=" + "'" + todo['id'] + "#" + todo['type'] + "'"+ "class='nextType' onclick='buttonDelete(id)'>X</button>" + 
						"</section>";
					}
				}
				newSection.innerHTML += msg;
			}
			else{
				console.log("fail");
			}
		}
	});
	
	// 서버와 클라이언트를 POST 방식으로 연결
	oReq.open("POST", "http://localhost:8080/TodoList/TodoTypeServlet", true);
	// 전송할 데이터의 타입을 설정
	oReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	// 서버에 데이터 전송
	oReq.send("type=" + type + "&id=" + id);
}

function buttonDelete(bid){
	var buttonInfo = bid.split('#');
    var type = buttonInfo[1];
    var id = buttonInfo[0];
	
	var oReq = new XMLHttpRequest();
	oReq.addEventListener("load", function() {
		if (oReq.readyState === XMLHttpRequest.DONE) {
			if (oReq.status === 200){
				// Type 변경된 할 일은 삭제한다.
				var targetButton = document.getElementById(bid);
				var target = targetButton.parentElement;
				var targetParent = target.parentElement;
				
				targetParent.removeChild(target);
			}
		}
	});
	
	oReq.open("POST", "http://localhost:8080/TodoList/TodoDeleteServlet");
	oReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	oReq.send("type=" + type + "&id=" + id);
}