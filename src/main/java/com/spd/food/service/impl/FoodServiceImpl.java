package com.spd.food.service.impl;

import com.spd.food.beans.Food;
import com.spd.food.mapper.FoodMapper;
import com.spd.food.service.FoodService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-15
 */
@Service
public class FoodServiceImpl extends ServiceImpl<FoodMapper, Food> implements FoodService {

}
