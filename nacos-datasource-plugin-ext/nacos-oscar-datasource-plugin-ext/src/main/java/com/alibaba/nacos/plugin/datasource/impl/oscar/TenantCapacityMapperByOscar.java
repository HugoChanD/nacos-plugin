package com.alibaba.nacos.plugin.datasource.impl.oscar;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.alibaba.nacos.common.utils.NamespaceUtil;
import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.TenantCapacityMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.ArrayList;
import java.util.List;

public class TenantCapacityMapperByOscar extends OscarAbstractMapper implements TenantCapacityMapper {

    @Override
    public MapperResult getCapacityList4CorrectUsage(MapperContext context) {
        String sql = getDatabaseDialect().getLimitTopSqlWithMark(
                "ELECT id, tenant_id FROM tenant_capacity WHERE id> AND  ROWNUM > ?");
        return new MapperResult(sql,
                CollectionUtils.list(context.getWhereParameter(FieldConstant.ID),
                        context.getWhereParameter(FieldConstant.LIMIT_SIZE)));
    }

    @Override
    public MapperResult incrementUsageWithDefaultQuotaLimit(MapperContext context) {
        return new MapperResult(
                "UPDATE tenant_capacity SET `usage` = `usage` + 1, gmt_modified = ? WHERE ((tenant_id = ? OR tenant_id IS NULL) OR tenant_id IS NULL) AND `usage` <"
                        + " ? AND quota = 0",
                CollectionUtils.list(context.getUpdateParameter(FieldConstant.GMT_MODIFIED),
                        context.getWhereParameter(FieldConstant.TENANT_ID),
                        context.getWhereParameter(FieldConstant.USAGE)));
    }

    @Override
    public MapperResult incrementUsageWithQuotaLimit(MapperContext context) {
        return new MapperResult(
                "UPDATE tenant_capacity SET `usage` = `usage` + 1, gmt_modified = ? WHERE (tenant_id = ? OR tenant_id IS NULL) AND `usage` < "
                        + "quota AND quota != 0",
                CollectionUtils.list(context.getUpdateParameter(FieldConstant.GMT_MODIFIED),
                        context.getWhereParameter(FieldConstant.TENANT_ID)));
    }

    @Override
    public MapperResult incrementUsage(MapperContext context) {
        return new MapperResult("UPDATE tenant_capacity SET `usage` = `usage` + 1, gmt_modified = ? WHERE (tenant_id = ? OR tenant_id IS NULL)",
                CollectionUtils.list(context.getUpdateParameter(FieldConstant.GMT_MODIFIED),
                        context.getWhereParameter(FieldConstant.TENANT_ID)));
    }

    @Override
    public MapperResult decrementUsage(MapperContext context) {
        return new MapperResult(
                "UPDATE tenant_capacity SET usage = usage - 1, gmt_modified = ? WHERE tenant_id = NVL(?, '"+NamespaceUtil.getNamespaceDefaultId()+"') AND usage > 0",
                CollectionUtils.list(context.getUpdateParameter(FieldConstant.GMT_MODIFIED),
                        context.getWhereParameter(FieldConstant.TENANT_ID)));
    }

    @Override
    public MapperResult correctUsage(MapperContext context) {
        return new MapperResult(
                "UPDATE tenant_capacity SET `usage` = (SELECT count(*) FROM config_info WHERE (tenant_id = ? OR tenant_id IS NULL)), "
                        + "gmt_modified = ? WHERE (tenant_id = ? OR tenant_id IS NULL)",
                CollectionUtils.list(context.getWhereParameter(FieldConstant.TENANT_ID),
                        context.getUpdateParameter(FieldConstant.GMT_MODIFIED),
                        context.getWhereParameter(FieldConstant.TENANT_ID)));
    }

    @Override
    public MapperResult insertTenantCapacity(MapperContext context) {
        List<Object> paramList = new ArrayList<>();
        paramList.add(context.getUpdateParameter(FieldConstant.TENANT_ID));
        paramList.add(context.getUpdateParameter(FieldConstant.QUOTA));
        paramList.add(context.getUpdateParameter(FieldConstant.MAX_SIZE));
        paramList.add(context.getUpdateParameter(FieldConstant.MAX_AGGR_COUNT));
        paramList.add(context.getUpdateParameter(FieldConstant.MAX_AGGR_SIZE));
        paramList.add(context.getUpdateParameter(FieldConstant.GMT_CREATE));
        paramList.add(context.getUpdateParameter(FieldConstant.GMT_MODIFIED));
        paramList.add(context.getWhereParameter(FieldConstant.TENANT_ID));

        return new MapperResult(
                "INSERT INTO tenant_capacity (tenant_id, quota, `usage`, `max_size`, max_aggr_count, max_aggr_size, "
                        + "gmt_create, gmt_modified) SELECT ?, ?, count(*), ?, ?, ?, ?, ? FROM config_info WHERE tenant_id=? OR tenant_id IS NULL;",
                paramList);
    }
}
