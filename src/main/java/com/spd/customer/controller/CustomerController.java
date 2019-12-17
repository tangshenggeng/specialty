package com.spd.customer.controller;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.spd.cart.beans.Cart;
import com.spd.cart.service.CartService;
import com.spd.code.beans.RegiterCode;
import com.spd.code.service.RegiterCodeService;
import com.spd.customer.beans.Customer;
import com.spd.customer.service.CustomerService;
import com.spd.utils.AnalysisKeyWordsListUtils;
import com.spd.utils.Msg;
import com.spd.utils.UUIDUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author spd
 * @since 2019-12-12
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	private CustomerService custSer;		//客户
	
	@Autowired
	private RegiterCodeService regiterCodeSer;
	
	@Autowired
	private CartService cartSer;
	
	/**
	 * 批量拉黑
	 * */
	@RequestMapping(value="/exceptionCustByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg exceptionCustByIds(@RequestBody ArrayList<Integer> list) {
		List<Customer> selectBatchIds = custSer.selectBatchIds(list);
		//Java 8 新特性+Lambda表达式
		selectBatchIds.forEach(cust -> cust.setCustState("异常"));
		boolean b = custSer.updateBatchById(selectBatchIds);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	/**
	 * 批量拉黑
	 * */
	@RequestMapping(value="/recoveryCustByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg recoveryCustByIds(@RequestBody ArrayList<Integer> list) {
		List<Customer> selectBatchIds = custSer.selectBatchIds(list);
		//Java 8 新特性+Lambda表达式
		selectBatchIds.forEach(cust -> cust.setCustState("正常"));
		boolean b = custSer.updateBatchById(selectBatchIds);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delCustByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delCustByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = custSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	/**
	 * 得到正常客户
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getNormalCustList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNormalCustList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String name = (String) afterMap.get("custName");
		String email = (String) afterMap.get("custEmail");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Customer> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("cust_name", name);
		}
		if(!email.equals("")) {
			wrapper.like("cust_email", email);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("cust_state","正常").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = custSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有正常客户");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到异常客户
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getAbnormalCustList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAbnormalCustList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String name = (String) afterMap.get("custName");
		String email = (String) afterMap.get("custEmail");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Customer> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("cust_name", name);
		}
		if(!email.equals("")) {
			wrapper.like("cust_email", email);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("cust_state","异常").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = custSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有异常客户");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	
	/**
	 *添加客户
	 * */
	@RequestMapping(value="/addCust",method=RequestMethod.POST)
	@ResponseBody
	public Msg addCust(Customer cust) {
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(cust.getCustName(),cust.getCustEmail());
		if(orNot) {
			return Msg.fail().add("msg", "客户已存在！");
		}
		cust.setCustIdent(UUIDUtil.createUUID());
		cust.setCustPwd("123456");
		cust.setCustState("正常");
		boolean b = custSer.insert(cust);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 登录
	 * */
	@RequestMapping(value="/loginInto",method=RequestMethod.POST)
	public String loginInto(Customer cust,HttpServletRequest req,Model model) {
		EntityWrapper<Customer> wrapper = new EntityWrapper<>();
		wrapper.eq("cust_email", cust.getFormCode())
		.or()
		.eq("cust_name",  cust.getFormCode());
		int count = custSer.selectCount(wrapper);
		if(count==0) {
			model.addAttribute("error", "您还未注册！请您先注册！");
			return "forward:/pages/login.jsp";
		}
		wrapper.eq("cust_pwd",cust.getCustPwd()).eq("cust_state","正常");
		Customer one = custSer.selectOne(wrapper);
		if(one==null) {
			model.addAttribute("error", "用户名或密码错误");
			return "forward:/pages/login.jsp";
		}
		req.getSession().setAttribute("name", one.getCustName());
		req.getSession().setAttribute("ident", one.getCustIdent());
		return "redirect:/pages/index.jsp";
	}
	/**
	 * 退出登录
	 * */
	@RequestMapping(value="/loginOut",method=RequestMethod.GET)
	public String loginOut(HttpServletRequest req) {
		req.getSession().invalidate();
		return "redirect:/pages/index.jsp";
	}
	
	/**
	 * 注册客户
	 * */
	@RequestMapping(value="/registerCust",method=RequestMethod.POST)
	public String registerCust(Customer cust,Model model) {
		if(cust.getAllow()==null) {
			model.addAttribute("error", "请勾选用户使用协议！");
			return "forward:/pages/register.jsp";
		}
		//验证两次输入的密码
		if(!cust.getFormPwd1().equals(cust.getFormPwd2())) {
			model.addAttribute("error", "两次密码不一致！");
			return "forward:/pages/register.jsp";
		}
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(cust.getCustName(),cust.getCustEmail());
		if(orNot) {
			model.addAttribute("error", "您已经注册过了！");
			return "forward:/pages/register.jsp";
		}
		//验证邮箱
		EntityWrapper<RegiterCode> codeWrapper = new EntityWrapper<>();
		codeWrapper.eq("regiter_email", cust.getCustEmail())
					.eq("code", cust.getFormCode());
		int count = regiterCodeSer.selectCount(codeWrapper);
		if(count == 0) {
			model.addAttribute("error", "验证码有误！");
			return "forward:/pages/register.jsp";
		}
		//删除对应邮箱验证码
		regiterCodeSer.delete(codeWrapper);
		//注册
		Customer entity = new Customer();
		entity.setCustPwd(cust.getFormPwd2());
		entity.setCustIdent(UUIDUtil.createUUID());
		entity.setCustName(cust.getCustName());
		entity.setCustEmail(cust.getCustEmail());
		entity.setCustState("正常");
		boolean b = custSer.insert(entity);
		if(b) {
			model.addAttribute("success", "注册成功！请登录！");
			return "forward:/pages/register.jsp";
		}else {
			model.addAttribute("error", "注册失败！");
			return "forward:/pages/register.jsp";
		}
	}
	/**
	 * 忘记密码
	 * */
	@RequestMapping(value="/forgetPwd",method=RequestMethod.POST)
	public String forgetPwd(Customer cust,Model model) {
		//验证两次输入的密码
		if(!cust.getFormPwd1().equals(cust.getFormPwd2())) {
			model.addAttribute("error", "两次密码不一致！");
			return "forward:/pages/forget-pwd.jsp";
		}
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(cust.getCustName(),cust.getCustEmail());
		if(!orNot) {
			model.addAttribute("error", "账号不存在！");
			return "forward:/pages/forget-pwd.jsp";
		}
		//验证邮箱
		EntityWrapper<RegiterCode> codeWrapper = new EntityWrapper<>();
		codeWrapper.eq("regiter_email", cust.getCustEmail())
		.eq("code", cust.getFormCode());
		int count = regiterCodeSer.selectCount(codeWrapper);
		if(count == 0) {
			model.addAttribute("error", "验证码有误！");
			return "forward:/pages/forget-pwd.jsp";
		}
		//删除对应邮箱验证码
		regiterCodeSer.delete(codeWrapper);
		
		EntityWrapper<Customer> wrapper = new EntityWrapper<>();
		wrapper.eq("cust_email", cust.getCustEmail())
		.eq("cust_state", "正常");
		int custCount = custSer.selectCount(wrapper);
		if(custCount==0) {
			model.addAttribute("error", "您的账号出现异常！");
			return "forward:/pages/forget-pwd.jsp";
		}
		cust.setCustPwd(cust.getFormPwd1());
		boolean b = custSer.update(cust, wrapper);
		if(b) {
			model.addAttribute("success", "修改成功！请登录！");
			return "forward:/pages/forget-pwd.jsp";
		}else {
			model.addAttribute("error", "修改失败！");
			return "forward:/pages/forget-pwd.jsp";
		}
	}
//========================页面跳转========================================
	/**
	 * 抽取方法，验证用户名和邮箱是否存在
	 * true 存在
	 * false 不存在	
	 * @return 
	 */
	public boolean repeatOrNot(String name,String email) {
		EntityWrapper<Customer> getCustWrapper = new EntityWrapper<>();
		getCustWrapper.eq("cust_email", email).orNew()
						.eq("cust_name", name);
		int count2 = custSer.selectCount(getCustWrapper);
		if(count2 != 0) {
			return true;
		}
		return false;
	}
	//添加客户
	@RequestMapping(value="/toAddCustPage")
	public String toAddCustPage() {
		return "/custs/add-cust";
	}
	
	//正常客户
	@RequestMapping("/toNormalCustPage")
	public String toNormalCustPage() {
		return "/custs/normal-custs";
	}
	//异常客户
	@RequestMapping("/toAbnormalCustPage")
	public String toAbnormalCustPage() {
		return "/custs/abnormal-custs";
	}
}

