package com.spd.order.beans;

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
 * @since 2019-12-17
 */
@TableName("tb_order")
public class Order extends Model<Order> {

    private static final long serialVersionUID = 1L;

    /**
     * 订单表id
     */
    @TableId(value = "order_id", type = IdType.AUTO)
    private Integer orderId;
    /**
     * 订单号
     */
    private String orderNum;
    /**
     * 所属客户
     */
    private Integer custId;
    /**
     * 总价
     */
    private Float totalPrice;
    /**
     * 支付方式
     */
    private String payWay;
    /**
     * 收货人
     */
    private String consignee;
    /**
     * 地址
     */
    private String address;
    /**
     * 手机号码
     */
    private String phone;
    /**
     * 订单状态
     */
    private String orderState;
    /**
     * 下单时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 收货时间
     */
    private Date receivingTime;
    /**
     * 快递公司
     * */
    private String expressCom;
    /**
     * 快递单号
     * */
    private String expressNum;
    /**
     * 退货原因
     * */
    private String returnReason;
    
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;

    @TableField(exist=false)
    public String cartIds;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Integer getCustId() {
        return custId;
    }

    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getReceivingTime() {
        return receivingTime;
    }

    public void setReceivingTime(Date receivingTime) {
        this.receivingTime = receivingTime;
    }

    public Integer getIsDel() {
        return isDel;
    }

    public void setIsDel(Integer isDel) {
        this.isDel = isDel;
    }

    @Override
    protected Serializable pkVal() {
        return this.orderId;
    }

	public String getCartIds() {
		return cartIds;
	}

	public void setCartIds(String cartIds) {
		this.cartIds = cartIds;
	}
	public String getExpressCom() {
		return expressCom;
	}

	public void setExpressCom(String expressCom) {
		this.expressCom = expressCom;
	}

	public String getExpressNum() {
		return expressNum;
	}

	public void setExpressNum(String expressNum) {
		this.expressNum = expressNum;
	}

	public String getReturnReason() {
		return returnReason;
	}

	public void setReturnReason(String returnReason) {
		this.returnReason = returnReason;
	}

	@Override
	public String toString() {
		return "Order [orderId=" + orderId + ", orderNum=" + orderNum + ", custId=" + custId + ", totalPrice="
				+ totalPrice + ", payWay=" + payWay + ", consignee=" + consignee + ", address=" + address + ", phone="
				+ phone + ", orderState=" + orderState + ", createTime=" + createTime + ", receivingTime="
				+ receivingTime + ", expressCom=" + expressCom + ", expressNum=" + expressNum + ", returnReason="
				+ returnReason + ", isDel=" + isDel + ", cartIds=" + cartIds + "]";
	}

    
}
