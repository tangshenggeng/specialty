package com.spd.cooperation.beans;

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
 * @author 时丕东
 * @since 2019-12-14
 */
@TableName("tb_cooperation")
public class Cooperation extends Model<Cooperation> {

    private static final long serialVersionUID = 1L;

    /**
     * 申请合作id
     */
    @TableId(value = "cooperation_id", type = IdType.AUTO)
    private Integer cooperationId;
    /**
     * 序列号
     */
    private String coopIdent;
    /**
     * 称呼
     */
    private String coopName;
    /**
     * 联系
     */
    private String coopEmail;
    /**
     * 电话
     */
    private String coopPhone;
    /**
     * 视频
     */
    private String coopVideo;
    /**
     * 省份
     */
    private String coopProvince;
    /**
     * 市区
     */
    private String coopCity;
    /**
     * 乡镇
     */
    private String coopCounty;
    /**
     * 详细地址
     */
    private String detailAddr;
    /**
     * 备注
     */
    private String coopRemark;
    /**
     * 状态（申请中or通过or异常or考察中or合作中or停止合作）
     */
    private String coopState;
    /**
     * 开始合作时间
     */
    private Date startTime;
    /**
     * 结束合作时间
     */
    private Date endTime;
    /**
     * 后台处理消息
     */
    private String adminHandle;
    /**
     * 申请时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;


    public Integer getCooperationId() {
        return cooperationId;
    }

    public void setCooperationId(Integer cooperationId) {
        this.cooperationId = cooperationId;
    }

    public String getCoopIdent() {
        return coopIdent;
    }

    public void setCoopIdent(String coopIdent) {
        this.coopIdent = coopIdent;
    }

    public String getCoopName() {
        return coopName;
    }

    public void setCoopName(String coopName) {
        this.coopName = coopName;
    }

    public String getCoopEmail() {
        return coopEmail;
    }

    public void setCoopEmail(String coopEmail) {
        this.coopEmail = coopEmail;
    }

    public String getCoopVideo() {
        return coopVideo;
    }

    public void setCoopVideo(String coopVideo) {
        this.coopVideo = coopVideo;
    }

    public String getCoopProvince() {
        return coopProvince;
    }

    public void setCoopProvince(String coopProvince) {
        this.coopProvince = coopProvince;
    }

    public String getCoopCity() {
        return coopCity;
    }

    public void setCoopCity(String coopCity) {
        this.coopCity = coopCity;
    }

    public String getCoopCounty() {
        return coopCounty;
    }

    public void setCoopCounty(String coopCounty) {
        this.coopCounty = coopCounty;
    }

    public String getDetailAddr() {
        return detailAddr;
    }

    public void setDetailAddr(String detailAddr) {
        this.detailAddr = detailAddr;
    }

    public String getCoopRemark() {
        return coopRemark;
    }

    public void setCoopRemark(String coopRemark) {
        this.coopRemark = coopRemark;
    }

    public String getCoopState() {
        return coopState;
    }

    public void setCoopState(String coopState) {
        this.coopState = coopState;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getAdminHandle() {
        return adminHandle;
    }

    public void setAdminHandle(String adminHandle) {
        this.adminHandle = adminHandle;
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
        return this.cooperationId;
    }

	public String getCoopPhone() {
		return coopPhone;
	}

	public void setCoopPhone(String coopPhone) {
		this.coopPhone = coopPhone;
	}

	@Override
	public String toString() {
		return "Cooperation [cooperationId=" + cooperationId + ", coopIdent=" + coopIdent + ", coopName=" + coopName
				+ ", coopEmail=" + coopEmail + ", coopPhone=" + coopPhone + ", coopVideo=" + coopVideo
				+ ", coopProvince=" + coopProvince + ", coopCity=" + coopCity + ", coopCounty=" + coopCounty
				+ ", detailAddr=" + detailAddr + ", coopRemark=" + coopRemark + ", coopState=" + coopState
				+ ", startTime=" + startTime + ", endTime=" + endTime + ", adminHandle=" + adminHandle + ", createTime="
				+ createTime + ", isDel=" + isDel + "]";
	}

    
}
