<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.ett.drv.model.admin.DictTypeModel"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.smartken.kia.core.util.EasyUiUtil"%>
<%@page import="com.smartken.kia.core.model.impl.*"%>
<%@page import="com.ett.model.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'menuConfig-success.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<jsp:include page="/plugin/index.jsp">
	 	<jsp:param value="jquery,easyui" name="plugin"/>
	</jsp:include>
   <jsp:include page="/css/index.jsp"></jsp:include>
   <jsp:include page="/js/index.jsp"></jsp:include>  
  </head>
<script type="text/javascript">
function operaFormatter(value,rowData,rowIndex){
    	var aEidt="<a title='编辑' href='javascript:void(0)' class='kia-icon edit' onclick='clickEditHandler("+rowData["id"]+");'></a>";
        return aEidt;
    }
function clickAddHandler(){ 
  		var href='<%=basePath%>'+"admin/Dicttype/to/addDict.action";
  		$("#divEditDict").dialog({
  			title:"新增字典类型 ",
			height:400,
			width:600,
			onClose:function(){ $('#test').datagrid('reload'); },
	    	modal:true,
			onBeforeOpen:function(){$(this).kiaIframe(href);}} 
		);    //   end:$("#divEdit").dialog
 }
function dblClickRowHandler(rowIndex,rowData){ 
	    var id=rowData["Id"];
	    var fullname=rowData["<%=DictTypeModel.F.CTypename%>"];
  		var href='<%=basePath%>'+"admin/Dicttype/to/modifyDict.action?id="+id;
  		$("#divEditDict").dialog({
  			title:"修改字典类型:"+fullname,
			height:400,
			width:600,
			onClose:function(){ $('#test').datagrid('reload'); },
	    	modal:true,
			onBeforeOpen:function(){$(this).kiaIframe(href);}} 
		);//   end:$("#divEdit").dialog
 }
function clickRemoveHandler(){ 
 		 $.messager.confirm('操作提示','确认删除字典类型 ?',function(yes){		 		
					var selectsRows=$("#test").datagrid("getSelections");
					var ids="";
					$.each(selectsRows,function(index,row){
							ids+=','+row['Id'];  
							});
					var action="<%=basePath%>"+"admin/Dictype/do/deleteDict.action";
					$.post(action,{ids:ids},
							function(str){
									str.messager();
									$("#test").datagrid("reload");
					});
		});  //$.messager
}
$(document).ready(function(){   
	$("#test").datagrid({fit:true,
	toolbar:[ 
			{text:"新增字典类型 ",
			iconCls:"icon-add",
			handler:clickAddHandler}
	, 
			{text:"删除字典类型 ",
			iconCls:"icon-remove",
			handler:clickRemoveHandler}
	] 
    ,
	columns:[ 
	[ 
	{field:"Id",checkbox:true},
	{field:"<%=DictTypeModel.F.CTypename%>",title:"类型名称",width:150},
	{field:"<%=DictTypeModel.F.CDescription%>",title:"类型描述",width:150}
	]
	] 
	,
	pagination:true,
	onDblClickRow:dblClickRowHandler
	,
	url:'<%=basePath%>'+"admin/Dicttype/datagrid/dict.action"} 
);    //   end:$("#tableDG").datagrid
}); //$(document).ready
</script>
  <body>
    <div class="innerDiv">
	<table id="test"></table>
	</div>
	<div id="divEditDict"></div>	
  </body>
</html>