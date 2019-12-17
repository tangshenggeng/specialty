package com.spd.order.service.impl;

import com.spd.order.beans.Order;
import com.spd.order.mapper.OrderMapper;
import com.spd.order.service.OrderService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 时丕东
 * @since 2019-12-17
 */
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {

}
