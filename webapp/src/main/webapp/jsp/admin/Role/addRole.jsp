<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartken.kia.core.model.impl.EasyUiModel"%>
<%@page import="com.ett.drv.model.admin.DepartmentModel"%>
<%@page import="com.ett.drv.model.admin.UserModel"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String adminUserPath=basePath+"/admin/Role";
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'menuConfig-success.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<jsp:include page="/plugin/index.jsp">
	 <jsp:param value="jquery,easyui" name="plugin"/>
	</jsp:include>
	<jsp:include page="/js/index.jsp"></jsp:include>
   <jsp:include page="/css/index.jsp"></jsp:include>
   
   
   <script type="text/javascript">
    
   function clickSave(){
			   $("#formRole").form('submit',{
				   url:'<%=basePath%>'+"admin/Role/do/addRole.action"
				  // alert('url');
				   ,onSubmit:function(){ return $(this).form("validate"); }
				   ,success:function(str){
				    $(this).form("clear");
				     str.messager();
				   }
			   });
   }
   
   </script>
   
  </head>
 
  <body>
  <div class="innerDiv">
     <form id="formRole"  method="post">
       <table class="editTable" cellspacing="0">
         <tbody>
           <tr>
             <th>角色名</th>
             <td style="width: 35%">
               <input name="CName"  type="text"   
                 class="<%=EasyUiModel.ValidateBox.CLASS %>"
                 <%=EasyUiModel.ValidateBox.Properties.REQUIRED(true) %>
               />
             </td>
            <th>描述</th>
             <td style="width: 35%">
               <input name="CDescription" type="text"  
               	class="<%=EasyUiModel.ValidateBox.CLASS %>"
                 <%=EasyUiModel.ValidateBox.Properties.REQUIRED(true) %>
               />
             </td>
           </tr>
           <tr>
            <th>介绍</th>
             <td style="width: 35%">
               <input name="CRolestring" type="text"  
               class="<%=EasyUiModel.ValidateBox.CLASS %>"
                 <%=EasyUiModel.ValidateBox.Properties.REQUIRED(true) %>
               />
             </td>          
           <tr>
             <td colspan="4" style="text-align: right">
             <a class="<%=EasyUiModel.LinkButton.CLASS %>"
                <%=EasyUiModel.LinkButton.Properties.ICON_CLS(EasyUiModel.ICON_SAVE) %>
                onclick="clickSave()" 
             >保存</a>
           </tr>
         </tbody>
       </table>
      </form>
    </div>
</body>
</html>