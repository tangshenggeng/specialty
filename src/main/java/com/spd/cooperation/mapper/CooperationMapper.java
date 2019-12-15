package com.spd.cooperation.mapper;

import com.spd.cooperation.beans.Cooperation;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-14
 */
public interface CooperationMapper extends BaseMapper<Cooperation> {
	@Select(value="select coop_ident as coopIdent  , coop_name as coopName  from tb_cooperation where coop_state = '合作中'")
	List<Map<String, String>> getCoopsBySelect();
}
