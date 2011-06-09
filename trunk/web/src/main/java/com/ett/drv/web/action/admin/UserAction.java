package com.ett.drv.web.action.admin;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ett.common.security.MD5Encrypt;
import com.ett.drv.model.admin.RoleModel;
import com.ett.drv.model.admin.UserModel;
import com.ett.drv.web.action.BaseAction;
import com.ett.drv.web.filter.AuthFilter;
import com.opensymphony.xwork2.ModelDriven;
import com.smartken.kia.core.model.impl.ResultModel;
import com.smartken.kia.core.util.EasyUiUtil;
import com.smartken.kia.core.util.ObjectUtil;
import com.smartken.kia.core.util.StringUtil;

public class UserAction extends BaseAction implements ModelDriven<UserModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserModel _userModel;
	@Override
	public void clear() {
	}	
	public String do_login(){
		String loginName=this.getParameter(UserModel.F.CLoginName);
		String pwd=this.getParameter(UserModel.F.CPwd);
		_userModel=adminBiz.login(loginName, pwd);
		if(_userModel!=null){
		   this.setSessionAttribute(AuthFilter.AUTH_USER, _userModel);
		   return "login_success";
		}else {
		   return "login_fail";
		}
	}
	public UserModel getModel() {
		if(isGet()){
			int id=ObjectUtil.formatInt(this.getParameter("id"));
			if(id==0)
			{
				_userModel=new UserModel();
			}else{
				this.adminBiz.loadCrudMapper(UserModel.class);
				_userModel=(UserModel) this.adminBiz.getModelEqPk(id);
			}
		}
		return _userModel;
	}
	@SuppressWarnings("unchecked")
	public void datagrid_users(){
	
		this.adminBiz.loadCrudMapper(UserModel.class);
		List list=this.adminBiz.getView();
		JSONObject jsonDG=EasyUiUtil.toJsonDataGrid(list,this.adminBiz.count());
		this.writePlainText(jsonDG.toString());
	}	
	public String to_editUser(){
	    return "jsp";
	}	
	public void  do_editUser(){
		int re=0;
		if(this.isPost()){
			this.adminBiz.loadCrudMapper(UserModel.class);
			MD5Encrypt mD5=new MD5Encrypt();
			try{
				// mD5.encrypt(UserModel.F.CPwd);
				String CPwd=_userModel.getCPwd();
				_userModel.setCPwd(mD5.encrypt(CPwd));
			} catch (Exception e) {
				e.printStackTrace();
			}
			re+=this.adminBiz.modifyOrAddModel(_userModel).getRe();
		}
		ResultModel resultModel=new ResultModel();
		if(re==1){
			resultModel.setTitle("操作成功");
			String pattern="";
			if(_userModel.getId()==null){
				pattern="用户管理:保存成功";
				resultModel.setAction(ResultModel.ACTION_CONFIRM);
				//hardware=new HardwareModel();
			}else {
				pattern="用户管理:保存成功";
			}
			resultModel.setMsg(pattern,re);;
			
		}else {
			resultModel.setAction(ResultModel.ACTION_ALERT);
			resultModel.setTitle("操作失败");
		}
		this.writePlainText(resultModel.toJson().toString());
	}
    @SuppressWarnings("unchecked")
	public void do_deleteUser(){
    	ArrayList lListIds=new ArrayList();
		String ids=this.getParameter("ids");
		int re=0;
	    if(ids!=null)
		{
             lListIds=StringUtil.splitToList(ids,",");
             this.adminBiz.loadCrudMapper(UserModel.class);
             re+=this.adminBiz.removeModelInPk(lListIds).getRe();
		}
		ResultModel resultModel=new ResultModel();
		if(re>0){
			resultModel.setTitle("操作成功");
			//resultModel.setAction(ResultModel.ACTION_CONFIRM);
			resultModel.setMsg("成功删除{0}个用户",re);
	
		}else {
			resultModel.setAction(ResultModel.ACTION_ALERT);
			resultModel.setTitle("操作失败");
			resultModel.setMsg("没有用户被删除");
		}
		this.writePlainText(resultModel.toJson().toString());   	
    }
    public void do_fuweiUser(){
    	ArrayList lListIds=new ArrayList();
		String ids=this.getParameter("ids");
		int re=0;
	    if(ids!=null)
		{
             lListIds=StringUtil.splitToList(ids,",");
             this.adminBiz.loadCrudMapper(UserModel.class);
             List UserModelList=this.adminBiz.getModelInPk(lListIds);
             for(int tu=0;tu<UserModelList.size();tu++){
            	UserModel userModel=(UserModel) UserModelList.get(tu);
            	userModel.setCPwd("123456");
            	this.adminBiz.modifyModel(userModel);
            	re++;
             }             
		}
		ResultModel resultModel=new ResultModel();
		if(re>0){
			resultModel.setTitle("操作成功");
			//resultModel.setAction(ResultModel.ACTION_CONFIRM);
			resultModel.setMsg("成功复位{0}个用户",re);
	
		}else {
			resultModel.setAction(ResultModel.ACTION_ALERT);
			resultModel.setTitle("操作失败");
			resultModel.setMsg("没有用户被复位");
		}
		this.writePlainText(resultModel.toJson().toString());   	
    }
    @SuppressWarnings("unchecked")
	public void combobox_deptid(){
    	List lListShool = null;
		try {
			lListShool = adminBiz.listSchool(null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONArray lJsonKscc= ObjectUtil.toJsonArray(lListShool);
		this.writePlainText(lJsonKscc.toString());
    }
    public void combobox_roleid(){
    	List lListRole = new ArrayList();
    	this.adminBiz.loadCrudMapper(RoleModel.class);
    	lListRole=this.adminBiz.getModel();
    	RoleModel roleModel=new RoleModel();
    	lListRole.add(roleModel);
		JSONArray lJsonKscc= ObjectUtil.toJsonArray(lListRole);
		this.writePlainText(lJsonKscc.toString());
    }
    @SuppressWarnings("unchecked")
	public void search_User(){
		UserModel query=new UserModel();
		String Username=this.getParameter("Username");
		if(StringUtil.isNotBlank(Username)){
			Username="%"+Username+"%";
			query.setCLoginName(Username);
		}
		String IRoleid=this.getParameter("IRoleid");
		if(StringUtil.isNotBlank(IRoleid)){
			query.setIRoleid(Integer.valueOf(IRoleid));
		}
        this.adminBiz.loadCrudMapper(UserModel.class);
        List list=this.adminBiz.getView(query,this.getPager());
    
		JSONObject jsonDg=EasyUiUtil.toJsonDataGrid(list);
		this.writePlainText(jsonDg.toString());
	}
}