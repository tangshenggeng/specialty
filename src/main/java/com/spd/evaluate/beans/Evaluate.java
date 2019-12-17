package com.spd.evaluate.beans;

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
@TableName("tb_evaluate")
public class Evaluate extends Model<Evaluate> {

    private static final long serialVersionUID = 1L;

    /**
     * 评论的id
     */
    @TableId(value = "evaluate_id", type = IdType.AUTO)
    private Integer evaluateId;
    /**
     * 评论的内容
     */
    private String evaluateText;
    /**
     * 客户id
     */
    private Integer custId;
    /**
     * 评价的食品
     */
    private Integer foodId;
    /**
     * 评价时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;


    public Integer getEvaluateId() {
        return evaluateId;
    }

    public void setEvaluateId(Integer evaluateId) {
        this.evaluateId = evaluateId;
    }

    public String getEvaluateText() {
        return evaluateText;
    }

    public void setEvaluateText(String evaluateText) {
        this.evaluateText = evaluateText;
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
        return this.evaluateId;
    }

    @Override
    public String toString() {
        return "Evaluate{" +
        ", evaluateId=" + evaluateId +
        ", evaluateText=" + evaluateText +
        ", custId=" + custId +
        ", foodId=" + foodId +
        ", createTime=" + createTime +
        ", isDel=" + isDel +
        "}";
    }
}
