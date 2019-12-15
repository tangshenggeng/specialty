package com.spd.cooperation.service.impl;

import com.spd.cooperation.beans.Cooperation;
import com.spd.cooperation.mapper.CooperationMapper;
import com.spd.cooperation.service.CooperationService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-14
 */
@Service
public class CooperationServiceImpl extends ServiceImpl<CooperationMapper, Cooperation> implements CooperationService {
	
	@Autowired
	private CooperationMapper coopMapper;
	
	@Override
	public List<Map<String, String>> getCoopsBySelect() {
		List<Map<String, String>> list= coopMapper.getCoopsBySelect();
		return list;
	}

}
