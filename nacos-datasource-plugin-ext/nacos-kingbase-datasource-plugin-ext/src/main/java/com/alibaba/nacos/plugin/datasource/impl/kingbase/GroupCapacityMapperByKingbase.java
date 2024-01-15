package com.alibaba.nacos.plugin.datasource.impl.kingbase;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.GroupCapacityMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

public class GroupCapacityMapperByKingbase extends KingbaseAbstractMapper implements GroupCapacityMapper {

    @Override
    public MapperResult selectGroupInfoBySize(MapperContext context) {
        String sql = getDatabaseDialect().getLimitTopSqlWithMark(
                "SELECT id, group_id FROM group_capacity WHERE id > ? ROWNUM > ?");
        return new MapperResult(sql, CollectionUtils.list(
                context.getWhereParameter(FieldConstant.ID), context.getPageSize()));
    }
}
