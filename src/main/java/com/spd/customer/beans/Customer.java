package com.spd.customer.beans;

import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author spd
 * @since 2019-12-12
 */
@TableName("tb_customer")
public class Customer extends Model<Customer> {

    private static final long serialVersionUID = 1L;

    /**
     * 客户id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 客户唯一标识
     */
    private String custIdent;
    /**
     * 客户登录名
     */
    private String custName;
    /**
     * 客户邮箱
     */
    private String custEmail;
    /**
     * 客户密码
     */
    private String custPwd;
    /**
     * 客户状态（正常or异常）
     */
    private String custState;
    /**
     * 注册时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;
    
    @TableField(exist=false)
    private String formPwd1;
    
    @TableField(exist=false)
    private String formPwd2;
    
    @TableField(exist=false)
    private String formCode;
    
    @TableField(exist=false)
    private String allow;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCustIdent() {
        return custIdent;
    }

    public void setCustIdent(String custIdent) {
        this.custIdent = custIdent;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getCustEmail() {
        return custEmail;
    }

    public void setCustEmail(String custEmail) {
        this.custEmail = custEmail;
    }

    public String getCustPwd() {
        return custPwd;
    }

    public void setCustPwd(String custPwd) {
        this.custPwd = custPwd;
    }

    public String getCustState() {
        return custState;
    }

    public void setCustState(String custState) {
        this.custState = custState;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getIsDel() {
        return isDel;
    }

    public void setIsDel(Integer isDel) {
        this.isDel = isDel;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

	public String getFormPwd1() {
		return formPwd1;
	}

	public void setFormPwd1(String formPwd1) {
		this.formPwd1 = formPwd1;
	}

	public String getFormPwd2() {
		return formPwd2;
	}

	public void setFormPwd2(String formPwd2) {
		this.formPwd2 = formPwd2;
	}

	public String getFormCode() {
		return formCode;
	}

	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	public String getAllow() {
		return allow;
	}

	public void setAllow(String allow) {
		this.allow = allow;
	}

	@Override
	public String toString() {
		return "Customer [id=" + id + ", custIdent=" + custIdent + ", custName=" + custName + ", custEmail=" + custEmail
				+ ", custPwd=" + custPwd + ", custState=" + custState + ", createTime=" + createTime + ", isDel="
				+ isDel + ", formPwd1=" + formPwd1 + ", formPwd2=" + formPwd2 + ", formCode=" + formCode + ", allow="
				+ allow + "]";
	}

	
    
}
