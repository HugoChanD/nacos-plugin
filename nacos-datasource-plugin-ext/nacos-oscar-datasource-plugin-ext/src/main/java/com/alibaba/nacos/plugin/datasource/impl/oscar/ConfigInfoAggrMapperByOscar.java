package com.alibaba.nacos.plugin.datasource.impl.oscar;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.ConfigInfoAggrMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.ArrayList;
import java.util.List;

public class ConfigInfoAggrMapperByOscar extends OscarAbstractMapper implements ConfigInfoAggrMapper {


    @Override
    public MapperResult findConfigInfoAggrByPageFetchRows(MapperContext context) {
        int startRow = context.getStartRow();
        int pageSize = context.getPageSize();
        String dataId = (String) context.getWhereParameter(FieldConstant.DATA_ID);
        String groupId = (String) context.getWhereParameter(FieldConstant.GROUP_ID);
        String tenantId = (String) context.getWhereParameter(FieldConstant.TENANT_ID);

        List<Object> sqlArgs = new ArrayList<>();
        sqlArgs.add(dataId);
        sqlArgs.add(groupId);
        sqlArgs.add(tenantId);

        String sqlBuilder = "SELECT data_id,group_id,tenant_id,datum_id,app_name,content FROM config_info_aggr WHERE data_id= ? AND "
                + "group_id= ? AND (tenant_id= ? OR tenant_id IS NULL) ORDER BY datum_id";
        String sql = getDatabaseDialect().getLimitPageSqlWithOffset(sqlBuilder, startRow, pageSize);
        return new MapperResult(sql, sqlArgs);
    }

    @Override
    public MapperResult batchRemoveAggr(MapperContext context) {
        final List<String> datumList = (List<String>) context.getWhereParameter(FieldConstant.DATUM_ID);
        final String dataId = (String) context.getWhereParameter(FieldConstant.DATA_ID);
        final String group = (String) context.getWhereParameter(FieldConstant.GROUP_ID);
        final String tenantTmp = (String) context.getWhereParameter(FieldConstant.TENANT_ID);

        List<Object> paramList = new ArrayList<>();
        paramList.add(dataId);
        paramList.add(group);
        paramList.add(tenantTmp);

        final StringBuilder datumString = new StringBuilder();
        for (String datum : datumList) {
            datumString.append('\'').append(datum).append("',");
        }
        datumString.deleteCharAt(datumString.length() - 1);
        String sql =
                "DELETE FROM config_info_aggr WHERE data_id = ? AND group_id = ? AND (tenant_id = ? OR tenant_id IS NULL) AND datum_id IN ("
                + datumString + ")";

        return new MapperResult(sql, paramList);
    }

    @Override
    public MapperResult aggrConfigInfoCount(MapperContext context) {
        final List<String> datumIds = (List<String>) context.getWhereParameter(FieldConstant.DATUM_ID);
        final Boolean isIn = (Boolean) context.getWhereParameter(FieldConstant.IS_IN);
        String dataId = (String) context.getWhereParameter(FieldConstant.DATA_ID);
        String group = (String) context.getWhereParameter(FieldConstant.GROUP_ID);
        String tenantTmp = (String) context.getWhereParameter(FieldConstant.TENANT_ID);

        List<Object> paramList = CollectionUtils.list(dataId, group, tenantTmp);

        StringBuilder sql = new StringBuilder(
                "SELECT count(*) FROM config_info_aggr WHERE data_id = ? AND group_id = ? AND (tenant_id = ? OR tenant_id IS NULL) AND datum_id");
        if (isIn) {
            sql.append(" IN (");
        }
        else {
            sql.append(" NOT IN (");
        }
        for (int i = 0; i < datumIds.size(); i++) {
            if (i > 0) {
                sql.append(", ");
            }
            sql.append('?');
        }
        sql.append(')');

        return new MapperResult(sql.toString(), paramList);
    }

    @Override
    public MapperResult findConfigInfoAggrIsOrdered(MapperContext context) {
        String dataId = (String) context.getWhereParameter(FieldConstant.DATA_ID);
        String groupId = (String) context.getWhereParameter(FieldConstant.GROUP_ID);
        String tenantId = (String) context.getWhereParameter(FieldConstant.TENANT_ID);

        String sql = "SELECT data_id,group_id,tenant_id,datum_id,app_name,content FROM "
                + "config_info_aggr WHERE data_id = ? AND group_id = ? AND (tenant_id = ? OR tenant_id IS NULL) ORDER BY datum_id";
        List<Object> paramList = CollectionUtils.list(dataId, groupId, tenantId);

        return new MapperResult(sql, paramList);
    }

}
