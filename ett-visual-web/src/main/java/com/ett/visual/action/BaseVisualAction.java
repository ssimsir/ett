package com.ett.visual.action;

import java.text.MessageFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;

import com.ett.visual.biz.IAdminBiz;
import com.ett.visual.model.admin.RoleModel;

import com.smartken.toyz4j.model.impl.BaseAction;
import com.smartken.toyz4j.model.impl.BaseModel;
import com.smartken.toyz4j.model.impl.ResultModel;
import com.smartken.toyz4j.pager.PageArrayList;
import com.smartken.toyz4j.pager.PageList;
import com.smartken.toyz4j.util.EasyUiUtil;
import com.smartken.toyz4j.util.ObjectUtil;
import com.smartken.toyz4j.util.StringUtil;

public abstract class BaseVisualAction<M extends BaseModel> extends BaseAction<M> {
      
	
	protected IAdminBiz adminBiz;

	public void setAdminBiz(IAdminBiz adminBiz) {
		this.adminBiz = adminBiz;
	}
	
	
	public  static String importPageResourceContext(){
	
		HttpServletRequest request=ServletActionContext.getRequest();
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		     boolean isDebug=true;
		     String jsTagPattern="<script type=\"text/javascript\" language=\"javascript\" src=\""+basePath+"{0}\"></script> \n";
		     String cssTagPatttern="<link rel=\"stylesheet\" type=\"text/css\" href=\""+basePath+"{0}\"> \n";
		     StringBuffer sbr=new StringBuffer("");
		     String pathPrefix="";

			 pathPrefix="/js3rd";
			 sbr.append(MessageFormat.format(cssTagPatttern, pathPrefix+"/jquery-easyui-1.2.5/themes/gray/easyui.css"));
			 sbr.append(MessageFormat.format(cssTagPatttern, pathPrefix+"/jquery-easyui-1.2.5/themes/icon.css"));
			 pathPrefix="/css";
			 sbr.append(MessageFormat.format(cssTagPatttern, pathPrefix+"/main.css"));
		     if(isDebug){

		    	 
		    	 pathPrefix="/js3rd";
		    	 sbr
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+"/jquery/jquery-1.7.1.min.js"))
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+"/jquery-pageload/jquery.pageload.js"))
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+ "/jquery-easyui-1.2.5/jquery.easyui.min.js"))
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+ "/jquery-easyui-1.2.5/locale/easyui-lang-zh_CN.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/jquery-easyui-datagridview/datagrid-detailview.js"))
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+ "/jquery-easyui-datagridview/datagrid-groupview.js"))
		    	 ;
		    	 
		    	 pathPrefix="/js";
		    	 sbr
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+"/Toyz4js.core.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/Toyz4js.setting.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/Toyz4js.prototype.Array.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/Toyz4js.prototype.String.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/Toyz4js.extends.jquery.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/Toyz4js.extends.easyui.js"))
		    	 .append(MessageFormat.format(jsTagPattern, pathPrefix+"/Toyz4js.plugin.CrudDatagrid.js"))
		    	 ;
		     }else{
		    	 
		    	 pathPrefix="/js3rd";
		    	 sbr
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+"/js3rd.package.js"));
		    	 
		    	 pathPrefix="/js";
		    	 sbr
		    	 .append(MessageFormat.format(jsTagPattern,pathPrefix+"/Toyz4js.package.min.js"));
		    	 
		     }
		     return sbr.toString();
	}


    public void do_add() {
		this.adminBiz.loadCrudMapper(this._model.getClass());
		
		_model.setPk(BaseModel.generalPK());
		ResultModel re=this.adminBiz.addModel(_model);
		this.writePlainText(re.toJson().toString());
	}
 
    public void do_update(){
		this.adminBiz.loadCrudMapper(this._model.getClass());
		ResultModel re=this.adminBiz.modifyModel(_model);
		this.writePlainText(re.toJson().toString());
    }
    
    public void do_save(){
		this.adminBiz.loadCrudMapper(this._model.getClass());
		if(ObjectUtil.isEquals(null, _model.getPk())){
			_model.setPk(BaseModel.generalPK());
		}
		ResultModel re=this.adminBiz.modifyOrAddModel(_model);
		this.writePlainText(re.toJson().toString());
    }

    public void do_remove(){
    	String ids=this.getParameter("ids");
    	List<String> listIds=StringUtil.splitToList(ids, ",");
    	ResultModel re=new ResultModel();
    	if(listIds.size()==0){
    		re.setMsg("没有记录被选中!");
    		re.setCode(ResultModel.CODE_ALERT);
    	    this.writePlainText(re.toJson().toString());
    	    return;
    	}
    	this.adminBiz.loadCrudMapper(this._model.getClass());
    	re=this.adminBiz.removeModelInPk(listIds);
    	this.writePlainText(re.toJson().toString());
    }
    
   
    public void datagrid_list(){
    	this.adminBiz.loadCrudMapper(this._model.getClass());
    	List pageList=this.adminBiz.getModel(this.getPager());
    	int count=this.adminBiz.count();
    	JSONObject datagrid= EasyUiUtil.toJsonDataGrid(pageList,count);
    	this.writePlainText(datagrid.toString());
    }
	
    public void datagrid_query(){
    	this.adminBiz.loadCrudMapper(this._model.getClass());
    	PageArrayList pageList=this.adminBiz.getModel(_model,this.getPager());
    	JSONObject datagrid= EasyUiUtil.toJsonDataGrid(pageList);
    	this.writePlainText(datagrid.toString());
    }
	
    
	
}
