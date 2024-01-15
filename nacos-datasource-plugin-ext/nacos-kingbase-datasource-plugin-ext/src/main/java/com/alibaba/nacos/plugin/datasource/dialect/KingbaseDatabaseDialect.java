package com.alibaba.nacos.plugin.datasource.dialect;

import com.alibaba.nacos.plugin.datasource.constants.DatabaseTypeConstant;

public class KingbaseDatabaseDialect extends AbstractDatabaseDialect{
    @Override
    public String getType() {
        return DatabaseTypeConstant.KINGBASE;
    }

    @Override
    public String getLimitTopSqlWithMark(String sql) {
        return sql + " LIMIT ? ";
    }

    @Override
    public String getLimitPageSqlWithMark(String sql) {
        return sql + "  OFFSET ? LIMIT ? ";
    }

    @Override
    public String getLimitPageSql(String sql, int pageNo, int pageSize) {
        return sql + "  OFFSET " + getPagePrevNum(pageNo, pageSize) + " LIMIT " + pageSize;
    }

    @Override
    public String getLimitPageSqlWithOffset(String sql, int startOffset, int pageSize){
        return sql + "  OFFSET " + startOffset + " LIMIT " + pageSize;
    }
}
