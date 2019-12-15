package com.spd.food.controller;


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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.spd.food.beans.Food;
import com.spd.food.service.FoodService;
import com.spd.utils.AnalysisKeyWordsListUtils;
import com.spd.utils.ConstantUtils;
import com.spd.utils.Msg;
import com.spd.utils.UUIDUtil;
import com.spd.utils.UploadFileUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-15
 */
@Controller
@RequestMapping("/food")
public class FoodController {

	@Autowired
	private FoodService foodSer;
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delFoodByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delFoodByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = foodSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	/**
	 * 批量下架
	 * */
	@RequestMapping(value="/hideFoodByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg hideFoodByIds(@RequestBody ArrayList<Integer> list) {
		List<Food> foods = foodSer.selectBatchIds(list);
		foods.forEach(food -> food.setIsShow("隐藏"));
		boolean b = foodSer.updateBatchById(foods);
		if(!b) {
			return Msg.fail().add("msg","下架失败！");
		}
		return Msg.success().add("msg", "下架成功");
	}
	/**
	 * 批量上架
	 * */
	@RequestMapping(value="/showFoodByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg showFoodByIds(@RequestBody ArrayList<Integer> list) {
		List<Food> foods = foodSer.selectBatchIds(list);
		foods.forEach(food -> food.setIsShow("展示"));
		boolean b = foodSer.updateBatchById(foods);
		if(!b) {
			return Msg.fail().add("msg","上架失败！");
		}
		return Msg.success().add("msg", "上架成功");
	}
	
	
	/**
	 * 得到展示的商品
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getShowFoodList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getShowFoodList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String name = (String) afterMap.get("foodName");
		String foodSupplier = (String) afterMap.get("foodSupplier");
		String foodSort = (String) afterMap.get("foodSort");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Food> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("food_name", name);
		}
		if(!foodSupplier.equals("")) {
			wrapper.eq("food_supplier", foodSupplier);
		}
		if(!foodSort.equals("")) {
			wrapper.eq("food_sort", foodSort);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("is_show","展示").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = foodSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有展示商品");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到隐藏的商品
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getHideFoodList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getHideFoodList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String name = (String) afterMap.get("foodName");
		String foodSupplier = (String) afterMap.get("foodSupplier");
		String foodSort = (String) afterMap.get("foodSort");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Food> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("food_name", name);
		}
		if(!foodSupplier.equals("")) {
			wrapper.eq("food_supplier", foodSupplier);
		}
		if(!foodSort.equals("")) {
			wrapper.eq("food_sort", foodSort);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("is_show","隐藏").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = foodSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有隐藏商品");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 修改食品
	 * */
	@RequestMapping(value="/editFood",method=RequestMethod.POST)
	@ResponseBody
	public Msg editFood(Food food) {
		boolean b = foodSer.updateById(food);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 添加食品
	 * */
	@RequestMapping(value="/addFood",method=RequestMethod.POST)
	@ResponseBody
	public Msg addFood(Food food) {
		String img = food.getFoodImg();
		if(img.equals("")) {
			return Msg.fail().add("msg", "请上传展示图片！");	
		}
		food.setFoodIdent(UUIDUtil.createUUID());
		boolean b = foodSer.insert(food);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	//============页面跳转==============
	/**
	 * 上传图片(介绍时)
	 * @return 
	 * */
	@RequestMapping(value="/introduceImg",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> introduceImg(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil util = new UploadFileUtil();
		String result = util.uploadImgFile(file, ConstantUtils.FOOD_INTRODUCE_IMG);
		if(result.equals("error")) {
			resultMap.put("code", 1);
			resultMap.put("msg", "图片上传失败");
			return resultMap;	
		}
		String technician = "/file/introduce/"+result;
		resultMap.put("errno", 0);
		resultMap.put("msg", "图片上传成功");
		resultMap.put("data", technician);
		return resultMap;
	}
	/**
	 * 上传图片（展示）
	 * @return 
	 * */
	@RequestMapping(value="/showImg",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> showImg(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil util = new UploadFileUtil();
		String result = util.uploadImgFile(file, ConstantUtils.FOOD_SHOW_IMG);
		if(result.equals("error")) {
			resultMap.put("code", 1);
			resultMap.put("msg", "图片上传失败");
			return resultMap;	
		}
		String technician = "/file/show/"+result;
		resultMap.put("errno", 0);
		resultMap.put("msg", "图片上传成功");
		resultMap.put("data", technician);
		return resultMap;
	}
	
	//去往添加食品页面
	@RequestMapping(value="/toAddFoodPage")
	public String toAddFoodPage() {
		return "/foods/add-foods";
	}
	//去往展示食品页面
	@RequestMapping(value="/toShowFoodPage")
	public String toShowFoodPage() {
		return "/foods/show-list";
	}
	//去往隐藏食品页面
	@RequestMapping(value="/toHideFoodPage")
	public String toHideFoodPage() {
		return "/foods/hide-list";
	}
	
}

