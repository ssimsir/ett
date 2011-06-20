<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String adminMenuPath = basePath + "admin/Menu";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<jsp:include page="/plugin/index.jsp">
			<jsp:param value="jquery,easyui" name="plugin" />
		</jsp:include>
		<jsp:include page="/css/index.jsp"></jsp:include>
		<jsp:include page="/js/index.jsp"></jsp:include>
		<style type="text/css">
table {
	
	border-style: solid;
	border-width: 1px;
}

td {
	
	border-width: 1px;
}
</style>
		<script type="text/javascript">
</script>
	</head>
	<body>
		<table style="text-align: center ;">
			<tr>
				<td style="background-color: rgb(208,227,248);" colspan="4">
						体检业务日志查询 
				</td>
			</tr>
			<tr>
				<td style="background-color: rgb(208,227,248);">
				证件号码：
				</td>
				<td>
					<input type="text" name=""/>
				</td>
				<td style="background-color: rgb(208,227,248);">
				档案编号：
				</td>
				<td>
					<input type="text" name=""/>
				</td>
			</tr>
				<tr>
				<td style="background-color: rgb(208,227,248);">
				体检日期起：
				</td>
					<td>
					<input type="text" name=""/>
				</td>
				<td style="background-color: rgb(208,227,248);">
				体检日期止：
				</td>
				<td>
					<input type="text" name=""/>
				</td>
			</tr>
				<tr>
				<td style="background-color: rgb(208,227,248);">
				操  作  者：
				</td>
					<td>
					<input type="text" name=""/>
				</td>
				<td style="background-color: rgb(208,227,248);">
					<input type="checkbox" name=""/>包含受理信息
				</td>
				<td style="background-color: rgb(208,227,248);">
					<input type="button" value="查询"/>
					<input type="button" value="打印体检信息"/>
				</td>
			</tr>
				<tr>
				<td colspan="4" style="background-color: rgb(208,227,248);">
					当前页1/1,共0条记录 &nbsp;&nbsp;
					<a href="">首页</a>
					|<a href="">尾页</a>
					|<a href="">上一页</a>
					|<a href="">下一页</a>
					<input type="text" name="">
					<a href="">跳到</a>
				</td>
			</tr>
		</table>
	</body>
</html>