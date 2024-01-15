package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.base.BaseConfigTagsRelationMapper;

public class ConfigTagsRelationMapperByHighgo extends BaseConfigTagsRelationMapper {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.HIGHGO;
    }
}
