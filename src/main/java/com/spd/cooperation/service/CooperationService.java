package com.spd.cooperation.service;

import com.spd.cooperation.beans.Cooperation;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-14
 */
public interface CooperationService extends IService<Cooperation> {

	List<Map<String, String>> getCoopsBySelect();

}
