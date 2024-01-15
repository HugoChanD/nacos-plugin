package com.alibaba.nacos.plugin.datasource.impl.highgo;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;
import com.alibaba.nacos.plugin.datasource.impl.mysql.HistoryConfigInfoMapperByMySql;

public class HistoryConfigInfoMapperByHighgo extends HistoryConfigInfoMapperByMySql {

    @Override
    public String getDataSource() {
        return DatabaseTypeConstant.HIGHGO;
    }
}
