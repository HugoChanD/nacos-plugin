package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseConfigInfoBetaMapper;

public class ConfigInfoBetaMapperByHighgo extends BaseConfigInfoBetaMapper {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.HIGHGO;
    }
}
