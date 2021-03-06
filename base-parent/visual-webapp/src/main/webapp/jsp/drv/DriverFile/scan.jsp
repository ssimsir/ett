<%@page import="com.ett.visual.applet.JsonFileUploadApplet"%>
<%@page import="com.ett.visual.action.BaseVisualAction"%>
<%@page import="com.ett.visual.model.BaseVisualModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    <%
      String basePath=BaseVisualAction.GetRootPath();
      String driverId=request.getParameter("driverId");
      
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%=BaseVisualAction.importPageResourceContext() %>

<style type="text/css">
 
 #divPreview{
    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);

 }
 
</style>

<script language="javascript" type="text/javascript">
 
var _path= "C:\\abc.jpg";

function start_preview(url)     
{   
	ScanCtrl.StartPreview();         
}   

function stop_preview(url)     
{   
	ScanCtrl.StopPreview();  
}   

function TakePic(url)     
{
	var jpgval= 36;
	
	var bok = 0;
	ScanCtrl.SetJpegQuality(jpgval); 
	if(ScanCtrl.QuickScan(_path))
	{
	    var divPreview = document.getElementById("divPreview");
	    divPreview.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = _path;
	}

//	ScanCtrl.Scan(path); 
}   

function Property(url)     
{   
	ScanCtrl.Property(); 
} 

function deloption()
{   
	var obj=document.getElementById("sel").options; 
	while (obj.length > 0)
	{
		obj.options.remove(obj.length - 1);   
	}   
}   

function seloption(index)
{   
	var objSelect=document.getElementById("sel").options; 
	objSelect.options[index].selected = true; 
}   

function addoption(s)   
{
	
	var obj=document.getElementById("sel").options; 
	
	var opt = new Option(s, obj.length ); 
	obj.options.add(opt);   
}


function deloption1()
{   
	var obj=document.getElementById("sel1").options; 
	while (obj.length > 0)
	{
		obj.options.remove(obj.length - 1);   
	}   
}   

function seloption1(index)
{   
	var objSelect=document.getElementById("sel1").options; 
	objSelect.options[index].selected = true; 
}   

function addoption1(s)   
{
	var   obj=document.getElementById("sel1").options; 
	var   opt = new Option(s, obj.length ); 
	obj.options.add(opt);   
}

function addoption2(s)   
{
	var obj=document.getElementById("sel2").options; 
	var opt = new Option(s, obj.length ); 
	obj.options.add(opt);   
}

function addoption3(s)   
{
	var obj=document.getElementById("sel3").options; 
	var opt = new Option(s, obj.length ); 
	obj.options.add(opt);   
}

function addoption4(s)   
{
	var obj=document.getElementById("sel4").options; 
	var opt = new Option(s, obj.length ); 
	obj.options.add(opt);   
}

function changeresolution()
{
	var num= ScanCtrl.GetResolutionCount();
	var obj=document.getElementById("sel").options; 
	var x = obj.selectedIndex;    

	if(x <= num)
	{
		ScanCtrl.SetResolution(x);          
	}
	else
		window.alert("Out of Range"); 
}

function contentLoad()
{
	opendevice();
}

function opendevice()
{

	  
	
	try{
	ScanCtrl.StartPreview();
	
	var num = ScanCtrl.GetResolutionCount();
	var selindex;
	var width = ScanCtrl.GetResolutionWidth(0);
	var height = ScanCtrl.GetResolutionHeight(0);  
	
	for(i=0;i<num;i++)
	{
		
		var w=ScanCtrl.GetResolutionWidth(i);
		var h=ScanCtrl.GetResolutionHeight(i);
		
		var str=w.toString()+"x"+h.toString();
		
		addoption(str);
		
		if(w==width){
			selindex=i;
		}
		
	}    
	
	seloption(selindex); 
	
	num = ScanCtrl.GetScanSizeCount();
	if(num == 8)
	{
		addoption1("All");
		addoption1("A3");
		addoption1("A4");
		addoption1("A5");
		addoption1("A6");
		addoption1("A7");
		addoption1("名片");
		addoption1("身份证");
		addoption1("自定义");
	}
	else
	{
		addoption1("All");
		addoption1("A4");
		addoption1("A5");
		addoption1("A6");
		addoption1("A7");
		addoption1("名片");
		addoption1("身份证");
		addoption1("自定义");
	}

	addoption2("0°");
	addoption2("90°");
	addoption2("270°");
	addoption2("180°");

	addoption3("彩色");
	addoption3("灰度");
	addoption3("黑白");

	for(i=1;i<256;i++){
		addoption4(i);
	}
	
	}catch(ex){alert(ex)}
	
}

function changescansize()
{
	var   num=ScanCtrl.GetScanSizeCount();
	var   obj=document.getElementById("sel1").options; 
	var   x = obj.selectedIndex;    
	if(x<=num)
	{
		ScanCtrl.SetScanSize(x);
	}
	else
		window.alert("Out of  Range"); 
}
   
function changerotate()
{
	var   obj=document.getElementById("sel2").options; 
	var   x = obj.selectedIndex;    

	if(x<4)
	{
		ScanCtrl.SetVideoRotate(x);
	}
	else
		window.alert("Out of  Range"); 
}
	  
function changecolor()
{
	var obj = document.getElementById("sel3").options; 
	var x = obj.selectedIndex;    

	if(x<3)
	{
		ScanCtrl.SetVideoColor(x);
	}
	else
		window.alert("Out of  Range"); 
}
	   
function changethresvalue()
{
	var   obj = document.getElementById("sel4").options; 
	var   x = obj.selectedIndex;    

	if( x < 256 && x > 0 )
	{
		ScanCtrl.SetThresVal(x);
	}
	else
		window.alert("Out of Range"); 
}


  $(document).ready(function(){
	  
	  try{
		
		//alert(_path);
		
		//alert(WshShell);
		
		
		//objFile.createTextRange().select();
		//alert(_path);
		//WshShell.SendKeys("{Tab}");
        //WshShell.SendKeys("{ }");
        
		
		//alert(objFile.value);
		//WshShell.SendKeys("{Enter}");
		//alert(objFile.value);
		//alert(objFile.outerHTML);
		//var context="";
		//context=objFile.outerHTML.replace(">"," value=\"C:\\abc.jpg\" >"); 
		//objFile.outerHTML=context;
		//alert(objFile.outerHTML);
		
		
		//alert(objFile.outerHTML);
		var ocxContext="<object classid=\"clsid:090457CB-DF21-41EB-84BB-39AAFC9E271A\" id=ScanCtrl   width=400 height=280> </object>";
		//$("#divCollect").append(ocxContext);
		//var objFile=document.all.tempFile;
		//objFile.outerHTML=objFile.outerHTML.replace(/(value=\").+\"/i,"$"+_path+"\""); 
		//objFile.focus(); 
		//WshShell.sendKeys(_path);
		
	  }catch(ex){alert(ex);}
	
  });

</script>


</head>
<body class="easyui-layout" >
 
     
     <div region="west" title="所有图片" style="width: 300px">
     </div>
     
     <div region="east" title="图片预览" style="width:300px">
        
        <div id="divPreview" style="max-width: 100%; height: 180px"  ></div>
          
     
    <!--  
       <applet codebase="<%=basePath %>/applet/"  id="upload" height="30" width="100"
       code="<%=JsonFileUploadApplet.class.getName() %>.class">
         <param name="btnText" value="上传">
         <param name="fileNames" value="tempFile">
         <param name="fileSrcs" value="c:\\abc.jpg">
         <param name="strNames" value="DriverPk">
         <param name="strValues" value="<%=driverId %>">
         <param name="action" value="<%=basePath %>/driver/DriverFile/do/saveScanFile.action">
       </applet>
   		  -->
     </div>
     
     <div region="center"  title="影像采集">
     
     <div id="divCollect">
     <object classid="clsid:090457CB-DF21-41EB-84BB-39AAFC9E271A" id=ScanCtrl CODEBASE="*.cab#version=1,0,0,1"  width=400 height=280> </object>
     </div>
     
            <input   TYPE="button"   VALUE="打开设备"   onClick="opendevice()">
     <!--  
     <input   TYPE="button"   VALUE="开始预览"   onClick="start_preview()"> 
     <input   TYPE="button"   VALUE="停止预览"   onClick="stop_preview()"> 
     -->
     
     
     <input   TYPE="button"   VALUE="拍照"   onClick="TakePic();">  
     <input   TYPE="button"   VALUE="属性"   onClick="Property()">  
     <select id="sel" name="sel"  onchange="changeresolution()"></select>
     <select id="sel1" name="sel1"  onchange="changescansize()"></select>
     <select id="sel2" name="sel2"  onchange="changerotate()"></select>
     <select id="sel3" name="sel3"  onchange="changecolor()"></select>
     <select id="sel4" name="sel4"  onchange="changethresvalue()"></select>  
     
     
   
     </div>
    
 
</body>
</html>