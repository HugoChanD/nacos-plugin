package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseConfigInfoAggrMapper;

public class ConfigInfoAggrMapperByHighgo extends BaseConfigInfoAggrMapper  {


    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.HIGHGO;
    }
}
