package com.spd.cart.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.spd.cart.beans.Cart;
import com.spd.cart.service.CartService;
import com.spd.customer.beans.Customer;
import com.spd.customer.service.CustomerService;
import com.spd.food.beans.Food;
import com.spd.food.service.FoodService;
import com.spd.utils.Msg;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author spd
 * @since 2019-12-17
 */
@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private CartService cartSer;
	
	@Autowired
	private CustomerService custSer;
	
	@Autowired
	private FoodService foodSer;
	
	/**
	 * 更新数量
	 * */
	@RequestMapping("/updateNum/{cartId}/{num}")
	@ResponseBody
	public void updateNum(@PathVariable("cartId")Integer cartId,@PathVariable("num")Integer num) {
		Cart cart = cartSer.selectById(cartId);
		cart.setFoodNum(num);
		cartSer.updateById(cart);
	}
	
	/**
	 * 删除
	 * */
	@RequestMapping("/delById/{id}")
	@ResponseBody
	public Msg delById(@PathVariable("id")Integer id) {
		boolean b = cartSer.deleteById(id);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 展示我的购物车
	 * @return 
	 * */
	@RequestMapping("/getMyCartsByShow/{id}")
	@ResponseBody
	public List<Map<String, Object>> getMyCartsByShow(@PathVariable("id")Integer custId) {
		List<Cart> cartList = cartSer.selectList(new EntityWrapper<Cart>().eq("cust_id", custId).eq("order_num", "0").orderBy("cart_id", false));
		List<Map<String, Object>> list = new ArrayList<>();
		for (Cart cart : cartList) {
			Map<String, Object> map = new HashMap<>();
			Food food = foodSer.selectById(cart.getFoodId());
			map.put("cartId", cart.getCartId());
			map.put("foodNum", cart.getFoodNum());
			map.put("foodImg", food.getFoodImg());
			map.put("foodMassUnit",food.getFoodMassUnit());
			map.put("foodName",food.getFoodName());
			map.put("foodPrice", food.getFoodPresentPrice());
			list.add(map);
		}
		return list;
	}
	
	/**
	 * 加入购物车
	 * */
	@RequestMapping("/addCartByCust/{ident}/{foodId}/{count}")
	@ResponseBody
	public Msg addCartByCust(@PathVariable("ident")String ident,
			@PathVariable("foodId")Integer foodId,@PathVariable("count")Integer count) {
		Customer cust = custSer.selectOne(new EntityWrapper<Customer>().eq("cust_ident", ident));
		if(cust==null) {
			return Msg.fail().add("msg", "用户不存在！");
		}
		Cart cart = new Cart();
		cart.setFoodId(foodId);
		cart.setFoodNum(count);
		cart.setOrderNum("0");
		cart.setCustId(cust.getId());
		boolean b = cartSer.insert(cart);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	//=====================我的购物车===============================
	@RequestMapping("/getMyCart/{ident}")
	public String getMyCart(@PathVariable("ident")String ident,Model model) {
		Customer cust = custSer.selectOne(new EntityWrapper<Customer>().eq("cust_ident", ident));
		if(cust==null) {
			model.addAttribute("error","登录超时或客户不存在！");
			return "forward:/pages/cart.jsp";
		}
		model.addAttribute("custId",cust.getId());
		return "forward:/pages/cart.jsp";
	}
}

