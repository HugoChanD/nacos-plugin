package com.alibaba.nacos.plugin.datasource.impl.oscar;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseConfigInfoMapper;

public class ConfigInfoMapperByOscar extends BaseConfigInfoMapper {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.OSCAR;
    }

}
