package com.alibaba.nacos.plugin.datasource.impl.kingbase;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.alibaba.nacos.common.utils.NamespaceUtil;
import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.ConfigInfoTagMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.Collections;

public class ConfigInfoTagMapperByKingbase extends KingbaseAbstractMapper implements ConfigInfoTagMapper {

    @Override
    public MapperResult findAllConfigInfoTagForDumpAllFetchRows(MapperContext context) {
        int startRow = context.getStartRow();
        int pageSize = context.getPageSize();
        String innerSql = getDatabaseDialect().getLimitPageSqlWithOffset(
                "SELECT id FROM config_info_tag  ORDER BY id ", startRow, pageSize);
        String sql = " SELECT t.id,data_id,group_id,tenant_id,tag_id,app_name,content,md5,gmt_modified "
                + " FROM (  " + innerSql + "  ) "
                + "g, config_info_tag t  WHERE g.id = t.id  ";
        return new MapperResult(sql, Collections.emptyList());
    }

    @Override
    public MapperResult updateConfigInfo4TagCas(MapperContext context) {
        Object content = context.getUpdateParameter(FieldConstant.CONTENT);
        Object md5 = context.getUpdateParameter(FieldConstant.MD5);
        Object srcIp = context.getUpdateParameter(FieldConstant.SRC_IP);
        Object srcUser = context.getUpdateParameter(FieldConstant.SRC_USER);
        Object gmtModified = context.getUpdateParameter(FieldConstant.GMT_MODIFIED);
        Object appName = context.getUpdateParameter(FieldConstant.APP_NAME);

        Object dataId = context.getWhereParameter(FieldConstant.DATA_ID);
        Object groupId = context.getWhereParameter(FieldConstant.GROUP_ID);
        Object tenantId = context.getWhereParameter(FieldConstant.TENANT_ID);
        Object tagId = context.getWhereParameter(FieldConstant.TAG_ID);
        Object oldMd5 = context.getWhereParameter(FieldConstant.MD5);

        String sql =
                "UPDATE config_info_tag SET content = ?, md5 = ?, src_ip = ?,src_user = ?,gmt_modified = ?,app_name = ? "
                        + "WHERE data_id = ? AND group_id = ? AND (tenant_id = ? OR tenant_id IS NULL) AND tag_id = ? AND (md5 = ? OR md5 IS NULL OR md5 = '')";
        return new MapperResult(sql,
                CollectionUtils.list(content, md5, srcIp, srcUser, gmtModified, appName, dataId, groupId, tenantId,
                        tagId, oldMd5));
    }
}
