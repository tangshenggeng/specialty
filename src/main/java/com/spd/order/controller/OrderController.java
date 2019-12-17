package com.spd.order.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.spd.cart.beans.Cart;
import com.spd.cart.service.CartService;
import com.spd.customer.beans.Customer;
import com.spd.customer.service.CustomerService;
import com.spd.food.beans.Food;
import com.spd.food.service.FoodService;
import com.spd.order.beans.Order;
import com.spd.order.service.OrderService;
import com.spd.utils.Msg;
import com.spd.utils.UUIDUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-17
 */
@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private OrderService orderSer;
	
	@Autowired
	private CustomerService custSer;
	
	@Autowired	
	private CartService cartSer;
	
	@Autowired
	private FoodService foodSer;
	
	/**
	 * 申请退货
	 * */
	@RequestMapping(value="/askReturnByCust",method=RequestMethod.POST)
	@ResponseBody
	public Msg askReturnByCust(Order o) {
		Order order = orderSer.selectOne(new EntityWrapper<Order>().eq("order_num", o.getOrderNum()).eq("order_state", "确认收货"));
		if(order==null) {
			return Msg.fail().add("msg", "订单不存在或状态不符");
		}
		order.setReturnReason(o.getReturnReason());
		order.setOrderState("退货申请中");
		boolean b = orderSer.updateById(order);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	/**
	 * 修改地址
	 * */
	@RequestMapping(value="/modifyAddrByCust",method=RequestMethod.POST)
	@ResponseBody
	public Msg modifyAddrByCust(Order o) {
		Order order = orderSer.selectOne(new EntityWrapper<Order>().eq("order_num", o.getOrderNum()).eq("order_state", "待发货"));
		if(order==null) {
			return Msg.fail().add("msg", "订单不存在或状态不符");
		}
		order.setAddress(o.getAddress());
		boolean b = orderSer.updateById(order);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 客户确认收货
	 * */
	@RequestMapping("/confirmGetByCust/{orderNum}")
	@ResponseBody
	public Msg confirmGetByCust(@PathVariable("orderNum")String orderNum) {
		Order order = orderSer.selectOne(new EntityWrapper<Order>().eq("order_num", orderNum).eq("order_state", "已发货"));
		if(order==null) {
			return Msg.fail().add("msg", "订单不存在或状态不符");
		}
		order.setOrderState("确认收货");
		order.setReceivingTime(new Date());
		boolean b = orderSer.updateById(order);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 获取我的订单
	 * @return 
	 * */
	@RequestMapping("/getMyOrdersByShow/{custId}")
	@ResponseBody
	public List<Map<String, Object>> getMyOrdersByShow(@PathVariable("custId")Integer custId) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<Order> orders = orderSer.selectList(new EntityWrapper<Order>().ne("order_state", "完成").eq("cust_id", custId).orderBy("order_id", false));
		for (Order order : orders) {
			Map<String, Object> map = new HashMap<>();		//orders的map
			List<Cart> carts = cartSer.selectList(new EntityWrapper<Cart>().eq("order_num", order.getOrderNum()).eq("cust_id", custId));
			List<Map<String, Object>> orderItems = new ArrayList<>();
			for (Cart cart : carts) {
				Map<String, Object> items = new HashMap<>();	//orderItem的map
				Food food = foodSer.selectById(cart.getFoodId());
				items.put("cartId", cart.getCartId());
				items.put("foodNum", cart.getFoodNum());
				items.put("foodImg", food.getFoodImg());
				items.put("foodMassUnit",food.getFoodMassUnit());
				items.put("foodName",food.getFoodName());
				items.put("foodPrice", food.getFoodPresentPrice());
				orderItems.add(items);
			}
			map.put("orderNum",order.getOrderNum());
			map.put("orderState",order.getOrderState());
			map.put("createTime",order.getCreateTime());
			map.put("totalPrice",order.getTotalPrice());
			map.put("expressCom",order.getExpressCom());
			map.put("expressNum",order.getExpressNum());
			map.put("myAddr",order.getAddress());
			map.put("items", orderItems);
			list.add(map);
		}
		return list;
	}
	
	/**
	 *提交订单
	 * */
	@RequestMapping(value="/addOrderByCust",method=RequestMethod.POST)
	@ResponseBody
	public Msg addOrderByCust(Order order) {
		if(order.getCartIds().isEmpty()) {
			return Msg.fail().add("msg", "购物车为空！");	
		}
		String orderNum = UUIDUtil.createUUID();	//订单号
		
		List<Integer> cartIds = analysisString(order.getCartIds());		//解析cartIds
		List<Cart> carts = cartSer.selectBatchIds(cartIds);
		for (Cart cart : carts) {
			cart.setOrderNum(orderNum);		//转换成订单条目
			Integer saleCount = cart.getFoodNum(); //购买量
			Food food = foodSer.selectById(cart.getFoodId());
			Integer stock = food.getFoodStock();		//获取库存
			if(stock-saleCount<0) {
				return Msg.fail().add("msg", food.getFoodName()+"库存只有"+food.getFoodStock()+"!");	
			}
			food.setFoodStock(stock-saleCount);
			food.setSoldNum(saleCount);
			foodSer.updateById(food);
		}
		cartSer.updateBatchById(carts);
		order.setOrderNum(orderNum);
		order.setOrderState("待发货");
		boolean b = orderSer.insert(order);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");	
	}
	//解析传过来的购物车id
	private List<Integer> analysisString(String cartIds) {
		List<Integer> list = new ArrayList<Integer>();
		String[] split = cartIds.split(",");
		for (int i = 0; i < split.length; i++) {
			int cartId = Integer.parseInt(split[i]);
			list.add(cartId);
		}
		return list;
	}
	//我的订单
	@RequestMapping("/getMyOrders/{ident}")
	public String getMyOrders(@PathVariable("ident")String ident,Model model) {
		Customer cust = custSer.selectOne(new EntityWrapper<Customer>().eq("cust_ident", ident));
		if(cust==null) {
			model.addAttribute("error","登录超时或客户不存在！");
			return "forward:/pages/user_center_order.jsp";
		}
		model.addAttribute("custId",cust.getId());
		return "forward:/pages/user_center_order.jsp";
	}
}

