package com.spd.admin.service.impl;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.spd.admin.beans.Admin;
import com.spd.admin.mapper.AdminMapper;
import com.spd.admin.service.AdminService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 项育林帅哥
 * @since 2019-12-01
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {

}
