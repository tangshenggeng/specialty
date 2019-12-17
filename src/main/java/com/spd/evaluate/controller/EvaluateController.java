package com.spd.evaluate.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.spd.cart.beans.Cart;
import com.spd.cart.service.CartService;
import com.spd.customer.beans.Customer;
import com.spd.customer.service.CustomerService;
import com.spd.evaluate.beans.Evaluate;
import com.spd.evaluate.service.EvaluateService;
import com.spd.order.beans.Order;
import com.spd.order.service.OrderService;
import com.spd.utils.Msg;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-17
 */
@Controller
@RequestMapping("/evaluate")
public class EvaluateController {

	@Autowired
	private OrderService orderSer;
	
	@Autowired	
	private CartService cartSer;
	
	@Autowired
	private EvaluateService evaSer;
	
	@Autowired
	private CustomerService custSer;
	
	/**
	 * 得到食品的评论
	 * @return 
	 * */
	@RequestMapping("/getEvaByShow/{foodId}")
	@ResponseBody
	public List<Map<String, Object>> getEvaByShow(@PathVariable("foodId")Integer foodId) {
		List<Map<String,Object>> arrayList = new ArrayList<>();
		List<Evaluate> evas = evaSer.selectList(new EntityWrapper<Evaluate>().eq("food_id", foodId).orderBy("evaluate_id", false));
		for (Evaluate evaluate : evas) {
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("text", evaluate.getEvaluateText());
			map.put("time", evaluate.getCreateTime());
			Customer customer = custSer.selectById(evaluate.getCustId());
			map.put("custName", customer.getCustName());
			arrayList.add(map);
		}
		return arrayList;
	}
	
	/**
	 * 评论
	 * */
	@RequestMapping(value="/addEvaluateByCust",method=RequestMethod.POST)
	@ResponseBody
	public Msg addEvaluateByCust(Order o) {
		Order orders = orderSer.selectOne(new EntityWrapper<Order>().eq("order_num", o.getOrderNum()).eq("order_state", "确认收货"));
		if(orders==null) {
			return Msg.fail().add("msg", "订单不存在或状态不符");
		}
		String evaText = o.getReturnReason();	//评价内容
		List<Evaluate> evaList = new ArrayList<>();
		List<Cart> cartIds = cartSer.selectList(new EntityWrapper<Cart>().eq("order_num", o.getOrderNum()));
		for (Cart cartId : cartIds) {
			Evaluate eva = new Evaluate();
			Cart cart = cartSer.selectById(cartId);
			eva.setCustId(orders.getCustId());
			eva.setEvaluateText(evaText);
			eva.setFoodId(cart.getFoodId());
			evaList.add(eva);
		}
		boolean b =evaSer.insertBatch(evaList);
		if(b) {
			orders.setOrderState("完成");
			orderSer.updateById(orders);
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
}

