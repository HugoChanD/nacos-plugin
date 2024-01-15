package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseConfigInfoMapper;

public class ConfigInfoMapperByHighgo extends BaseConfigInfoMapper {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.POSTGRESQL;
    }
}
