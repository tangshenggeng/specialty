package com.spd.cart.beans;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
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
 * @since 2019-12-17
 */
@TableName("tb_cart")
public class Cart extends Model<Cart> {

    private static final long serialVersionUID = 1L;

    /**
     * 购物车id
     */
    @TableId(value = "cart_id", type = IdType.AUTO)
    private Integer cartId;
    /**
     * 客户id
     */
    private Integer custId;
    /**
     * 食品id
     */
    private Integer foodId;
    /**
     * 数量
     */
    private Integer foodNum;
    
    /**
     * 订单号(默认0是没有加入订单)
     * */
    public String orderNum;

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public Integer getCustId() {
        return custId;
    }

    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public Integer getFoodId() {
        return foodId;
    }

    public void setFoodId(Integer foodId) {
        this.foodId = foodId;
    }

    public Integer getFoodNum() {
        return foodNum;
    }

    public void setFoodNum(Integer foodNum) {
        this.foodNum = foodNum;
    }

    @Override
    protected Serializable pkVal() {
        return this.cartId;
    }

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	@Override
	public String toString() {
		return "Cart [cartId=" + cartId + ", custId=" + custId + ", foodId=" + foodId + ", foodNum=" + foodNum
				+ ", orderNum=" + orderNum + "]";
	}

    
}
