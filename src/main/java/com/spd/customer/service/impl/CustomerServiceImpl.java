package com.spd.customer.service.impl;

import com.spd.customer.beans.Customer;
import com.spd.customer.mapper.CustomerMapper;
import com.spd.customer.service.CustomerService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author spd
 * @since 2019-12-12
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {

}
