package com.ett.visual.action.driver;

import com.ett.visual.action.BaseVisualAction;
import com.ett.visual.model.driver.DriverFileModel;
import com.smartken.toyz4j.model.impl.BaseAction;

public class DriverFileAction extends BaseVisualAction<DriverFileModel> {

	public DriverFileModel getModel() {
		// TODO Auto-generated method stub
		if(_model==null){
			_model=new DriverFileModel();
		}
		return _model;
	}

}
