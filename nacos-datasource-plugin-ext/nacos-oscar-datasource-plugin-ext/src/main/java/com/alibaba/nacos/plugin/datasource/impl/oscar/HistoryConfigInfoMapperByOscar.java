package com.alibaba.nacos.plugin.datasource.impl.oscar;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.HistoryConfigInfoMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.ArrayList;
import java.util.List;

public class HistoryConfigInfoMapperByOscar extends OscarAbstractMapper implements HistoryConfigInfoMapper {

    @Override
    public MapperResult removeConfigHistory(MapperContext context) {
        String sql = "DELETE FROM his_config_info WHERE gmt_modified < ? AND ROWNUM > ?";
        return new MapperResult(sql,
                CollectionUtils.list(context.getWhereParameter(FieldConstant.START_TIME),
                        context.getWhereParameter(FieldConstant.LIMIT_SIZE)));
    }

    @Override
    public MapperResult findConfigHistoryFetchRows(MapperContext context) {
        String dataId = (String) context.getWhereParameter(FieldConstant.DATA_ID);
        String groupId = (String) context.getWhereParameter(FieldConstant.GROUP_ID);
        String tenantId = (String) context.getWhereParameter(FieldConstant.TENANT_ID);

        List<Object> sqlArgs = new ArrayList<>();
        sqlArgs.add(dataId);
        sqlArgs.add(groupId);
        sqlArgs.add(tenantId);

        String sqlBuilder =
                "SELECT nid,data_id,group_id,tenant_id,app_name,src_ip,src_user,op_type,gmt_create,gmt_modified FROM his_config_info "
                        + "WHERE data_id = ? AND group_id = ? AND (tenant_id = ? OR tenant_id IS NULL) ORDER BY nid DESC";
        return new MapperResult(sqlBuilder, sqlArgs);
    }

    @Override
    public MapperResult pageFindConfigHistoryFetchRows(MapperContext context) {
        String dataId = (String) context.getWhereParameter(FieldConstant.DATA_ID);
        String groupId = (String) context.getWhereParameter(FieldConstant.GROUP_ID);
        String tenantId = (String) context.getWhereParameter(FieldConstant.TENANT_ID);

        List<Object> sqlArgs = new ArrayList<>();
        sqlArgs.add(dataId);
        sqlArgs.add(groupId);
        sqlArgs.add(tenantId);

        String sql =
                "SELECT nid,data_id,group_id,tenant_id,app_name,src_ip,src_user,op_type,gmt_create,gmt_modified FROM his_config_info "
                        + " WHERE data_id = ? AND group_id = ? AND  (tenant_id = ? OR tenant_id IS NULL)  "
                        + " ORDER BY nid DESC LIMIT "
                        + context.getStartRow() + "," + context.getPageSize();
        return new MapperResult(sql, sqlArgs);
    }

}
