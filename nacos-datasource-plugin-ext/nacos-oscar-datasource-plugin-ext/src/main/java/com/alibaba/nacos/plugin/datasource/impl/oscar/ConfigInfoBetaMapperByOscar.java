package com.alibaba.nacos.plugin.datasource.impl.oscar;

import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.ConfigInfoBetaMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ConfigInfoBetaMapperByOscar extends OscarAbstractMapper implements ConfigInfoBetaMapper {

    @Override
    public MapperResult findAllConfigInfoBetaForDumpAllFetchRows(MapperContext context) {
        int startRow = context.getStartRow();
        int pageSize = context.getPageSize();

        String sql = " SELECT t.id,data_id,group_id,tenant_id,app_name,content,md5,gmt_modified,beta_ips,encrypted_data_key "
                + " FROM ( SELECT rownum ROW_ID,id FROM config_info_beta  WHERE  ROW_ID<=  " + (startRow + pageSize)
                + " ORDER BY id )" + " g, config_info_beta t WHERE g.id = t.id AND g.ROW_ID >" + startRow;
        return new MapperResult(sql, Collections.emptyList());
    }

    @Override
    public MapperResult updateConfigInfo4BetaCas(MapperContext context) {
        final String sql = "UPDATE config_info_beta SET content = ?,md5 = ?,beta_ips = ?,src_ip = ?,src_user = ?,gmt_modified = ?,app_name = ? "
                + "WHERE data_id = ? AND group_id = ? AND (tenant_id = ? OR tenant_id IS NULL) AND (md5 = ? or md5 is null or md5 = '')";
        List<Object> paramList = new ArrayList<>();

        paramList.add(context.getUpdateParameter(FieldConstant.CONTENT));
        paramList.add(context.getUpdateParameter(FieldConstant.MD5));
        paramList.add(context.getUpdateParameter(FieldConstant.BETA_IPS));
        paramList.add(context.getUpdateParameter(FieldConstant.SRC_IP));
        paramList.add(context.getUpdateParameter(FieldConstant.SRC_USER));
        paramList.add(context.getUpdateParameter(FieldConstant.GMT_MODIFIED));
        paramList.add(context.getUpdateParameter(FieldConstant.APP_NAME));

        paramList.add(context.getWhereParameter(FieldConstant.DATA_ID));
        paramList.add(context.getWhereParameter(FieldConstant.GROUP_ID));
        paramList.add(context.getWhereParameter(FieldConstant.TENANT_ID));
        paramList.add(context.getWhereParameter(FieldConstant.MD5));

        return new MapperResult(sql, paramList);
    }

}
