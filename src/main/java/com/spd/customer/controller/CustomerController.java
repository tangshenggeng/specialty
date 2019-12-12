package com.spd.customer.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.spd.code.beans.RegiterCode;
import com.spd.code.service.RegiterCodeService;
import com.spd.customer.beans.Customer;
import com.spd.customer.service.CustomerService;
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
	
}

