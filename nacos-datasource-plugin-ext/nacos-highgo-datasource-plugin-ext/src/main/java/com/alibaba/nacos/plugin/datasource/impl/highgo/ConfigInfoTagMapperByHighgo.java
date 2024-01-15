package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseConfigInfoTagMapper;

public class ConfigInfoTagMapperByHighgo extends BaseConfigInfoTagMapper {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.HIGHGO;
    }
}
