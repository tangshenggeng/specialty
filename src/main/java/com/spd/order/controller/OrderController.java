package com.spd.order.controller;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.mysql.fabric.xmlrpc.base.Array;
import com.spd.cart.beans.Cart;
import com.spd.cart.service.CartService;
import com.spd.cooperation.beans.Cooperation;
import com.spd.customer.beans.Customer;
import com.spd.customer.service.CustomerService;
import com.spd.food.beans.Food;
import com.spd.food.service.FoodService;
import com.spd.order.beans.Order;
import com.spd.order.service.OrderService;
import com.spd.utils.AnalysisKeyWordsListUtils;
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
	 * 通过订单号查询到商品
	 * @return 
	 * */
	@RequestMapping("/getFoodInfoByOrderNum/{orderNum}")
	@ResponseBody
	public List<Map<String, Object>> getFoodInfoByOrderNum(@PathVariable("orderNum")String orderNum) {
		List<Map<String,Object>> infos = new ArrayList<Map<String,Object>>();
		List<Cart> list = cartSer.selectList(new  EntityWrapper<Cart>().eq("order_num", orderNum));
		
		Customer customer = custSer.selectById(list.get(0).getCustId());
		Map<String,Object> custInfo = new HashMap<String, Object>();
		custInfo.put("custName", customer.getCustName());
		infos.add(custInfo);
		for (Cart cart : list) {
			Map<String,Object> map = new HashMap<String, Object>();
			Food food = foodSer.selectById(cart.getFoodId());
			map.put("foodName", food.getFoodName());
			map.put("foodNum", cart.getFoodNum());
			infos.add(map);
		}
		return infos;
	}
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delOrdersByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delOrdersByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = orderSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	/**
	 * 填写快递信息
	 * */
	@RequestMapping(value="/writeExpressInfo",method=RequestMethod.POST)
	@ResponseBody
	public Msg writeExpressInfo(Order order) {
		order.setOrderState("已发货");
		boolean b = orderSer.updateById(order);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	/**
	 * 同意退货
	 * */
	@RequestMapping(value="/agreeById/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg deliveryById(@PathVariable("id")Integer id) {
		Order order = orderSer.selectById(id);
		order.setOrderState("完成");
		boolean b = orderSer.updateById(order);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 得到待发货订单
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getWaitList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getWaitList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		
		String orderNum = (String) afterMap.get("orderNum");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Order> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!orderNum.equals("")) {
			wrapper.eq("order_num", orderNum);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("order_state","待发货");
		Page<Map<String, Object>> mapsPage = orderSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有待发货的订单");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到已完成订单
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getCompleteList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCompleteList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		
		String orderNum = (String) afterMap.get("orderNum");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Order> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!orderNum.equals("")) {
			wrapper.eq("order_num", orderNum);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("order_state","完成");
		Page<Map<String, Object>> mapsPage = orderSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有已完成的订单");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到已发货订单
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getAlreadyList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAlreadyList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		
		String orderNum = (String) afterMap.get("orderNum");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Order> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!orderNum.equals("")) {
			wrapper.eq("order_num", orderNum);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("order_state","已发货");
		Page<Map<String, Object>> mapsPage = orderSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有已发货的订单");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到确认收货订单
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getConfirmList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getConfirmList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		
		String orderNum = (String) afterMap.get("orderNum");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Order> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!orderNum.equals("")) {
			wrapper.eq("order_num", orderNum);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("order_state","确认收货");
		Page<Map<String, Object>> mapsPage = orderSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有确认收货的订单");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到申请退货订单
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getAskList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAskList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		
		String orderNum = (String) afterMap.get("orderNum");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Order> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!orderNum.equals("")) {
			wrapper.eq("order_num", orderNum);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("order_state","退货申请中");
		Page<Map<String, Object>> mapsPage = orderSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有申请退货的订单");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	
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
	//=====================页面跳转======================
	//去往待发货页面
	@RequestMapping("/toWaitPage")
	public String toWaitPage() {
		return "orders/wait-list";
	}
	//去往已发货页面
	@RequestMapping("/toAlreadyPage")
	public String toAlreadyPage() {
		return "orders/already-list";
	}
	//去往确认收货页面
	@RequestMapping("/toConfirmPage")
	public String toConfirmPage() {
		return "orders/confirm-list";
	}
	//去往申请退货页面
	@RequestMapping("/toAskPage")
	public String toAskPage() {
		return "orders/ask-list";
	}
	//去往完成页面
	@RequestMapping("/toCompletePage")
	public String toCompletePage() {
		return "orders/complete-list";
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

