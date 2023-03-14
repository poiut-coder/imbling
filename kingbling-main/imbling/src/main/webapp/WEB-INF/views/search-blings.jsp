<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>귀금속 검색</title>
</head>
<body>

	<h2>귀금속 검색</h2>
	<input type="text" id="bling-category3">
	<button id="search-btn">검색</button>
	<hr>
	
	<table id="bling-list" border="1" style="width:700px;margin:0 auto">
	<thead>
		<tr>
			<th>이미지</th>
			<th>상품정보</th>
		</tr>
	</thead>
	<tbody>
	
	</tbody>
	</table>
	
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	<script type="text/javascript">
	$(function() {
		$('#search-btn').on('click', function(event) {
			const category3 = $('#bling-category3').val();
			if (category3.length == 0) {
				alert('검색어를 입력하세요');
				return;
			}
			
			$.ajax({
				"url": "search-product-info",
				"data": "category3=" + category3,
				"method": "get",
				"dataType": "json",
				"success": function(response, status, xhr) {
					if (response.result == "success") {
						const tbody = $('#bling-list tbody');
						tbody.empty(); // 기존의 하위 요소(tr) 모두 제거
						const blings = response.blings;
						$.each(blings, function(idx, bling) {
							const tr = $("<tr></tr>");
							tbody.append(tr);
							tr.append('<td><img src="' + bling.image + '" style="width:100px"></td>');
							
							const td = $('<td></td>');
							td.append('<p>' + bling.category3 + '</p>');
							td.append('<p>' + bling.title + '</p>');
							td.append('<p>' + bling.lprice + '원</p>');			
							tr.append(td);
						});
					} else {
						alert(response.result);
					}
				},
				"error": function(xhr, status, err) {
					
				}
			});
			
		});
	});
	</script>

</body>
</html>