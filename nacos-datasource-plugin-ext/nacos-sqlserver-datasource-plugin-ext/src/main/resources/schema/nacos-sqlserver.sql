/*
 * Copyright 1999-2018 Alibaba Group Holding Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************/
/*   表名称 = config_info                  */
/******************************************/
CREATE TABLE config_info (
	id bigint IDENTITY(1,1) NOT NULL,
	data_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	content nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	md5 nvarchar(32) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	gmt_create datetime2(0) DEFAULT getdate() NOT NULL,
	gmt_modified datetime2(0) DEFAULT getdate() NOT NULL,
	src_user nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NULL,
	src_ip nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	app_name nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	c_desc nvarchar(256) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	c_use nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	effect nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	[type] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	c_schema nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NULL,
	encrypted_data_key nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	CONSTRAINT PK_config_info_id PRIMARY KEY (id),
	CONSTRAINT config_info$uk_configinfo_datagrouptenant UNIQUE (data_id,group_id,tenant_id)
);

/******************************************/
/*   表名称 = config_info_aggr             */
/******************************************/
CREATE TABLE config_info_aggr (
	id bigint IDENTITY(1,1) NOT NULL,
	data_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	datum_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	content nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	gmt_modified datetime2(0) NOT NULL,
	app_name nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	CONSTRAINT PK_config_info_aggr_id PRIMARY KEY (id),
	CONSTRAINT config_info_aggr$uk_configinfoaggr_datagrouptenantdatum UNIQUE (data_id,group_id,tenant_id,datum_id)
);


/******************************************/
/*   表名称 = config_info_beta             */
/******************************************/
CREATE TABLE config_info_beta (
	id bigint IDENTITY(1,1) NOT NULL,
	data_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	app_name nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	content nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	beta_ips nvarchar(1024) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	md5 nvarchar(32) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	gmt_create datetime2(0) DEFAULT getdate() NOT NULL,
	gmt_modified datetime2(0) DEFAULT getdate() NOT NULL,
	src_user nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NULL,
	src_ip nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	encrypted_data_key nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	CONSTRAINT PK_config_info_beta_id PRIMARY KEY (id),
	CONSTRAINT config_info_beta$uk_configinfobeta_datagrouptenant UNIQUE (data_id,group_id,tenant_id)
);

/******************************************/
/*   表名称 = config_info_tag              */
/******************************************/
CREATE TABLE config_info_tag (
	id bigint IDENTITY(1,1) NOT NULL,
	data_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	tag_id nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	app_name nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	content nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	md5 nvarchar(32) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	gmt_create datetime2(0) DEFAULT getdate() NOT NULL,
	gmt_modified datetime2(0) DEFAULT getdate() NOT NULL,
	src_user nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NULL,
	src_ip nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_config_info_tag_id PRIMARY KEY (id),
	CONSTRAINT config_info_tag$uk_configinfotag_datagrouptenanttag UNIQUE (data_id,group_id,tenant_id,tag_id)
);

/******************************************/
/*   表名称 = config_tags_relation         */
/******************************************/
CREATE TABLE config_tags_relation (
	id bigint NOT NULL,
	tag_name nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	tag_type nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	data_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	nid bigint IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_config_tags_relation_nid PRIMARY KEY (nid),
	CONSTRAINT config_tags_relation$uk_configtagrelation_configidtag UNIQUE (id,tag_name,tag_type)
);
CREATE NONCLUSTERED INDEX idx_tenant_id ON config_tags_relation (tenant_id);

/******************************************/
/*   表名称 = group_capacity               */
/******************************************/
CREATE TABLE group_capacity (
	id numeric(20,0) IDENTITY(1,1) NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NOT NULL,
	quota bigint DEFAULT 0 NOT NULL,
	[usage] bigint DEFAULT 0 NOT NULL,
	max_size bigint DEFAULT 0 NOT NULL,
	max_aggr_count bigint DEFAULT 0 NOT NULL,
	max_aggr_size bigint DEFAULT 0 NOT NULL,
	max_history_count bigint DEFAULT 0 NOT NULL,
	gmt_create datetime2(0) DEFAULT getdate() NOT NULL,
	gmt_modified datetime2(0) DEFAULT getdate() NOT NULL,
	CONSTRAINT PK_group_capacity_id PRIMARY KEY (id),
	CONSTRAINT group_capacity$uk_group_id UNIQUE (group_id)
);

/******************************************/
/*   表名称 = his_config_info              */
/******************************************/
CREATE TABLE his_config_info (
	id numeric(20,0) NOT NULL,
	nid numeric(20,0) IDENTITY(1,1) NOT NULL,
	data_id nvarchar(255) COLLATE Chinese_PRC_CI_AS NOT NULL,
	group_id nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	app_name nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	content nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	md5 nvarchar(32) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	gmt_create datetime2(0) DEFAULT getdate() NOT NULL,
	gmt_modified datetime2(0) DEFAULT getdate() NOT NULL,
	src_user nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NULL,
	src_ip nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	op_type nchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	encrypted_data_key nvarchar(MAX) COLLATE Chinese_PRC_CI_AS NOT NULL,
	CONSTRAINT PK_his_config_info_nid PRIMARY KEY (nid)
);
CREATE NONCLUSTERED INDEX idx_did ON his_config_info (data_id);
CREATE NONCLUSTERED INDEX idx_gmt_create ON his_config_info (gmt_create);
CREATE NONCLUSTERED INDEX idx_gmt_modified ON his_config_info (gmt_modified);


/******************************************/
/*   表名称 = tenant_capacity              */
/******************************************/
CREATE TABLE tenant_capacity (
	id numeric(20,0) IDENTITY(1,1) NOT NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NOT NULL,
	quota bigint DEFAULT 0 NOT NULL,
	[usage] bigint DEFAULT 0 NOT NULL,
	max_size bigint DEFAULT 0 NOT NULL,
	max_aggr_count bigint DEFAULT 0 NOT NULL,
	max_aggr_size bigint DEFAULT 0 NOT NULL,
	max_history_count bigint DEFAULT 0 NOT NULL,
	gmt_create datetime2(0) DEFAULT getdate() NOT NULL,
	gmt_modified datetime2(0) DEFAULT getdate() NOT NULL,
	CONSTRAINT PK_tenant_capacity_id PRIMARY KEY (id),
	CONSTRAINT tenant_capacity$uk_tenant_id UNIQUE (tenant_id)
);


CREATE TABLE tenant_info (
	id bigint IDENTITY(1,1) NOT NULL,
	kp nvarchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	tenant_id nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	tenant_name nvarchar(128) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	tenant_desc nvarchar(256) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	create_source nvarchar(32) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	gmt_create bigint NOT NULL,
	gmt_modified bigint NOT NULL,
	CONSTRAINT PK_tenant_info_id PRIMARY KEY (id),
	CONSTRAINT tenant_info$uk_tenant_info_kptenantid UNIQUE (kp,tenant_id)
);
CREATE NONCLUSTERED INDEX idx_tenant_id ON tenant_info (tenant_id);

CREATE TABLE users (
	username varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	password varchar(500) COLLATE Chinese_PRC_CI_AS NOT NULL,
	enabled smallint NOT NULL,
	CONSTRAINT PK_users_username PRIMARY KEY (username)
);

CREATE TABLE roles (
	username varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[role] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	CONSTRAINT roles$idx_user_role UNIQUE (username,[role])
);

CREATE TABLE permissions (
	[role] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	resource varchar(128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[action] varchar(8) COLLATE Chinese_PRC_CI_AS NOT NULL,
	CONSTRAINT permissions$uk_role_permission UNIQUE ([role],resource,[action])
);


INSERT INTO users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, [role]) VALUES ('nacos', 'ROLE_ADMIN');