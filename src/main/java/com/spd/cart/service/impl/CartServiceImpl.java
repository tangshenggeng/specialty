package com.spd.cart.service.impl;

import com.spd.cart.beans.Cart;
import com.spd.cart.mapper.CartMapper;
import com.spd.cart.service.CartService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author spd
 * @since 2019-12-17
 */
@Service
public class CartServiceImpl extends ServiceImpl<CartMapper, Cart> implements CartService {

}
