package com.huilian.hlej.hcf.vo;

import java.io.Serializable;
import java.sql.Timestamp;

import com.huilian.hlej.jet.common.persistence.BaseDataEntity;
import com.huilian.hlej.jet.common.utils.excel.annotation.ExcelField;

/**
 * 设备警告实体类
 * 
 * @author LongZhangWei
 * @date 2017年12月25日 上午9:42:35
 */
public class EquipmentWarnVo extends BaseDataEntity<EquipmentWarnVo> implements Serializable {

	/**
	 * 序列号
	 */
	private static final long serialVersionUID = 1L;

	// 机器编号
	private String vendCode;
	// 位置简述
	private String location;
	// 详细地址
	private String address;
	// 故障状态
	private Integer faultState;
	private String faultStateStr;
	// 报警编号
	private String warnNo;
	// 报警描述
	private String warnDes;
	// 报警时间
	private Timestamp warnTime;
	private String warnTimeStr;

	@ExcelField(title = "机器编号", align = 2, sort = 1)
	public String getVendCode() {
		return vendCode;
	}

	public void setVendCode(String vendCode) {
		this.vendCode = vendCode;
	}

	@ExcelField(title = "位置简述", align = 2, sort = 2)
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@ExcelField(title = "详细地址", align = 2, sort = 3)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getFaultState() {
		return faultState;
	}

	public void setFaultState(Integer faultState) {
		this.faultState = faultState;
	}

	@ExcelField(title = "故障状态", align = 2, sort = 4)
	public String getFaultStateStr() {
		if (faultState.intValue() == 1) {
			faultStateStr = "正常";
		}
		if (faultState.intValue() == 2) {
			faultStateStr = "故障";
		}
		return faultStateStr;
	}

	public void setFaultStateStr(String faultStateStr) {
		this.faultStateStr = faultStateStr;
	}

	@ExcelField(title = "报警编号", align = 2, sort = 5)
	public String getWarnNo() {
		return warnNo;
	}

	public void setWarnNo(String warnNo) {
		this.warnNo = warnNo;
	}

	@ExcelField(title = "报警描述", align = 2, sort = 6)
	public String getWarnDes() {
		return warnDes;
	}

	public void setWarnDes(String warnDes) {
		this.warnDes = warnDes;
	}

	public Timestamp getWarnTime() {
		return warnTime;
	}

	public void setWarnTime(Timestamp warnTime) {
		this.warnTime = warnTime;
	}

	@ExcelField(title = "报警时间", align = 2, sort = 7)
	public String getWarnTimeStr() {
		return warnTimeStr;
	}

	public void setWarnTimeStr(String warnTimeStr) {
		this.warnTimeStr = warnTimeStr;
	}

}
