package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseGroupCapacityMapper;

public class GroupCapacityMapperByHighgo extends BaseGroupCapacityMapper {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.HIGHGO;
    }
}
