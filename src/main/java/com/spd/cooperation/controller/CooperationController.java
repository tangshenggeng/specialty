package com.spd.cooperation.controller;


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
import com.spd.cooperation.beans.Cooperation;
import com.spd.cooperation.service.CooperationService;
import com.spd.customer.beans.Customer;
import com.spd.utils.AnalysisKeyWordsListUtils;
import com.spd.utils.ConstantUtils;
import com.spd.utils.EmailUntils;
import com.spd.utils.Msg;
import com.spd.utils.UUIDUtil;
import com.spd.utils.UploadFileUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-14
 */
@Controller
@RequestMapping("/cooperation")
public class CooperationController {
	
	@Autowired
	private CooperationService coopSer;
	
	/**
	 * 考察中
	 * */
	@RequestMapping(value="/investigationCoop",method=RequestMethod.POST)
	@ResponseBody
	public Msg investigationCoop(Cooperation coop) {
		EmailUntils untils = new EmailUntils();
		untils.sendEmailToCooper(coop.getCoopEmail(), coop.getAdminHandle());
		coop.setCoopState("考察中");
		boolean b = coopSer.updateById(coop);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	/**
	 * 未通过
	 * */
	@RequestMapping(value="/abnormalCoop",method=RequestMethod.POST)
	@ResponseBody
	public Msg abnormalCoop(Cooperation coop) {
		EmailUntils untils = new EmailUntils();
		untils.sendEmailToCooper(coop.getCoopEmail(), coop.getAdminHandle());
		coop.setCoopState("未通过");
		boolean b = coopSer.updateById(coop);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	/**
	 * 修改
	 * */
	@RequestMapping(value="/editCoop",method=RequestMethod.POST)
	@ResponseBody
	public Msg editCoop(Cooperation coop) {
		boolean b = coopSer.updateById(coop);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delCoopByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delCustByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = coopSer.deleteBatchIds(list);
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
	@RequestMapping(value="/getApplicationList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getApplicationList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		
		String name = (String) afterMap.get("coopName");
		String coopProvince = (String) afterMap.get("coopProvince");
		String coopCity = (String) afterMap.get("coopCity");
		String coopCounty = (String) afterMap.get("coopCounty");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Cooperation> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("coop_name", name);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		if(!(coopProvince.equals("")||coopProvince.equals("0"))) {
			wrapper.like("coop_province", coopProvince);
		}
		if(!(coopCity.equals("")||coopCity.equals("0"))) {
			wrapper.like("coop_city", coopCity);
		}
		if(!(coopCounty.equals("")||coopCounty.equals("0"))) {
			wrapper.like("coop_county", coopCounty);
		}
		wrapper.eq("coop_state","申请中").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = coopSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有申请中的合作");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	
	/**
	 * 申请合作
	 * */
	@RequestMapping(value="/addCoopera",method=RequestMethod.POST)
	@ResponseBody
	public Msg addCoopera(Cooperation coop) {
		if(coop.getCoopProvince().equals("请选择省")||coop.getCoopCity().equals("请选择市")||coop.getCoopCounty().equals("请选择区")) {
			return Msg.fail().add("msg", "请选择城市！");
		}
		String video = coop.getCoopVideo();
		if(video.equals("")) {
			return Msg.fail().add("msg", "请选择视频并上传！");
		}
		coop.setCoopState("申请中");
		coop.setCoopIdent(UUIDUtil.createUUID());
		boolean b = coopSer.insert(coop);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	
	/**
	 * 上传头像
	 * @return 
	 * */
	@RequestMapping(value="/uploadVideo",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadHeaderImg(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil upUtil = new UploadFileUtil();
		String result = upUtil.uploadVideoFile(file, ConstantUtils.COOPERATION_VIDEO);
		if(result.equals("error")) {
			resultMap.put("code", 1);
			resultMap.put("msg", "视频上传失败，视频大小不得超过50M！");
			return resultMap;	
		}
		String url = "/file/videos/"+result;
		resultMap.put("code", 0);
		resultMap.put("msg", "视频上传成功");
		resultMap.put("data", url);
		return resultMap;
	}
	
	//====================页面跳转======================
	@RequestMapping(value="/toApplicationPage")
	public String toApplicationPage() {
		return "/cooperations/application-list";
	}
	
}

