package com.spd.food.beans;

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
 * @since 2019-12-15
 */
@TableName("tb_food")
public class Food extends Model<Food> {

    private static final long serialVersionUID = 1L;

    /**
     * 商品id
     */
    @TableId(value = "food_id", type = IdType.AUTO)
    private Integer foodId;
    /**
     * 唯一标识
     */
    private String foodIdent;
    /**
     * 商品名称
     */
    private String foodName;
    /**
     * 商品描述
     */
    private String foodDesc;
    /**
     * 商品介绍
     */
    private String foodIntroduce;
    /**
     * 原价
     */
    private Float foodOldPrice;
    /**
     * 现价
     */
    private Float foodPresentPrice;
    /**
     * 质量单位
     */
    private String foodMassUnit;
    /**
     * 现货数量
     */
    private Integer foodStock;
    /**
     * 商品分类
     */
    private String foodSort;
    /**
     * 图片地址
     */
    private String foodImg;
    /**
     * 供应者唯一标识
     */
    private String foodSupplier;
    /**
     * 是否展示
     */
    private String isShow;
    /**
     * 已售
     * */
    private Integer soldNum;
    /**
     * 上架时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;


    public Integer getFoodId() {
        return foodId;
    }

    public void setFoodId(Integer foodId) {
        this.foodId = foodId;
    }

    public String getFoodIdent() {
        return foodIdent;
    }

    public void setFoodIdent(String foodIdent) {
        this.foodIdent = foodIdent;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getFoodDesc() {
        return foodDesc;
    }

    public void setFoodDesc(String foodDesc) {
        this.foodDesc = foodDesc;
    }

    public String getFoodIntroduce() {
        return foodIntroduce;
    }

    public void setFoodIntroduce(String foodIntroduce) {
        this.foodIntroduce = foodIntroduce;
    }

    public Float getFoodOldPrice() {
        return foodOldPrice;
    }

    public void setFoodOldPrice(Float foodOldPrice) {
        this.foodOldPrice = foodOldPrice;
    }

    public Float getFoodPresentPrice() {
        return foodPresentPrice;
    }

    public void setFoodPresentPrice(Float foodPresentPrice) {
        this.foodPresentPrice = foodPresentPrice;
    }

    public String getFoodMassUnit() {
        return foodMassUnit;
    }

    public void setFoodMassUnit(String foodMassUnit) {
        this.foodMassUnit = foodMassUnit;
    }

    public Integer getFoodStock() {
        return foodStock;
    }

    public void setFoodStock(Integer foodStock) {
        this.foodStock = foodStock;
    }

    public String getFoodSort() {
        return foodSort;
    }

    public void setFoodSort(String foodSort) {
        this.foodSort = foodSort;
    }

    public String getFoodImg() {
        return foodImg;
    }

    public void setFoodImg(String foodImg) {
        this.foodImg = foodImg;
    }

    public String getFoodSupplier() {
        return foodSupplier;
    }

    public void setFoodSupplier(String foodSupplier) {
        this.foodSupplier = foodSupplier;
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
        return this.foodId;
    }

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public Integer getSoldNum() {
		return soldNum;
	}

	public void setSoldNum(Integer soldNum) {
		this.soldNum = soldNum;
	}

	@Override
	public String toString() {
		return "Food [foodId=" + foodId + ", foodIdent=" + foodIdent + ", foodName=" + foodName + ", foodDesc="
				+ foodDesc + ", foodIntroduce=" + foodIntroduce + ", foodOldPrice=" + foodOldPrice
				+ ", foodPresentPrice=" + foodPresentPrice + ", foodMassUnit=" + foodMassUnit + ", foodStock="
				+ foodStock + ", foodSort=" + foodSort + ", foodImg=" + foodImg + ", foodSupplier=" + foodSupplier
				+ ", isShow=" + isShow + ", soldNum=" + soldNum + ", createTime=" + createTime + ", isDel=" + isDel
				+ "]";
	}

	

}
