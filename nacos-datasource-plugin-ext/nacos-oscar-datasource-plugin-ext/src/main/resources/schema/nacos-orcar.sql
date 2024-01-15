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
CREATE TABLE CONFIG_INFO
(
    ID bigint NOT NULL AUTO_INCREMENT,
    DATA_ID character varying(255) NOT NULL,
    GROUP_ID character varying(128) ,
    "CONTENT" clob NOT NULL,
    MD5 character varying(32) ,
    GMT_CREATE timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    GMT_MODIFIED timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    SRC_USER clob ,
    SRC_IP character varying(50) ,
    APP_NAME character varying(128) ,
    TENANT_ID character varying(128) DEFAULT '' ,
    C_DESC character varying(256) ,
    C_USE character varying(64) ,
    EFFECT character varying(64) ,
    "TYPE" character varying(64) ,
    C_SCHEMA clob ,
    ENCRYPTED_DATA_KEY clob NOT NULL,
    CONSTRAINT CONFIG_INFO_PKEY PRIMARY KEY (ID),
    CONSTRAINT CONFIG_INFO_UK_CONFIGINFO_DATAGROUPTENANT_KEY UNIQUE (DATA_ID, GROUP_ID, TENANT_ID)
);

/******************************************/
/*   表名称 = config_info_aggr             */
/******************************************/
CREATE TABLE CONFIG_INFO_AGGR
(
    ID bigint NOT NULL AUTO_INCREMENT,
    DATA_ID character varying(255) NOT NULL,
    GROUP_ID character varying(128) NOT NULL,
    DATUM_ID character varying(255) NOT NULL,
    "CONTENT" clob NOT NULL,
    GMT_MODIFIED timestamp without time zone NOT NULL,
    APP_NAME character varying(128) ,
    TENANT_ID character varying(128) DEFAULT '' ,
    CONSTRAINT CONFIG_INFO_AGGR_PKEY PRIMARY KEY (ID),
    CONSTRAINT CONFIG_INFO_AGGR_UK_CONFIGINFOAGGR_DATAGROUPTENANTDATUM_KEY UNIQUE (DATA_ID, GROUP_ID, TENANT_ID, DATUM_ID)
);


/******************************************/
/*   表名称 = config_info_beta             */
/******************************************/
CREATE TABLE CONFIG_INFO_BETA
(
    ID bigint NOT NULL AUTO_INCREMENT,
    DATA_ID character varying(255) NOT NULL,
    GROUP_ID character varying(128) NOT NULL,
    APP_NAME character varying(128) ,
    "CONTENT" clob NOT NULL,
    BETA_IPS character varying(1024) ,
    MD5 character varying(32) ,
    GMT_CREATE timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    GMT_MODIFIED timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    SRC_USER clob ,
    SRC_IP character varying(50) ,
    TENANT_ID character varying(128) DEFAULT '' ,
    ENCRYPTED_DATA_KEY clob NOT NULL,
    CONSTRAINT CONFIG_INFO_BETA_PKEY PRIMARY KEY (ID),
    CONSTRAINT CONFIG_INFO_BETA_UK_CONFIGINFOBETA_DATAGROUPTENANT_KEY UNIQUE (DATA_ID, GROUP_ID, TENANT_ID)
);

/******************************************/
/*   表名称 = config_info_tag              */
/******************************************/
CREATE TABLE CONFIG_INFO_TAG
(
    ID bigint NOT NULL AUTO_INCREMENT,
    DATA_ID character varying(255) NOT NULL,
    GROUP_ID character varying(128) NOT NULL,
    TENANT_ID character varying(128) DEFAULT '' ,
    TAG_ID character varying(128) NOT NULL,
    APP_NAME character varying(128) ,
    "CONTENT" clob NOT NULL,
    MD5 character varying(32) ,
    GMT_CREATE timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    GMT_MODIFIED timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    SRC_USER clob ,
    SRC_IP character varying(50) ,
    CONSTRAINT CONFIG_INFO_TAG_PKEY PRIMARY KEY (ID),
    CONSTRAINT CONFIG_INFO_TAG_UK_CONFIGINFOTAG_DATAGROUPTENANTTAG_KEY UNIQUE (DATA_ID, GROUP_ID, TENANT_ID, TAG_ID)
);

/******************************************/
/*   表名称 = config_tags_relation         */
/******************************************/
CREATE TABLE CONFIG_TAGS_RELATION
(
    ID bigint NOT NULL,
    TAG_NAME character varying(128) NOT NULL,
    TAG_TYPE character varying(64) ,
    DATA_ID character varying(255) NOT NULL,
    GROUP_ID character varying(128) NOT NULL,
    TENANT_ID character varying(128) DEFAULT '' ,
    NID bigint NOT NULL AUTO_INCREMENT,
    CONSTRAINT CONFIG_TAGS_RELATION_PKEY PRIMARY KEY (NID),
    CONSTRAINT CONFIG_TAGS_RELATION_UK_CONFIGTAGRELATION_CONFIGIDTAG_KEY UNIQUE (ID, TAG_NAME, TAG_TYPE)
);

/******************************************/
/*   表名称 = group_capacity               */
/******************************************/
CREATE TABLE GROUP_CAPACITY
(
    ID bigint NOT NULL AUTO_INCREMENT,
    GROUP_ID character varying(128) DEFAULT '' NOT NULL,
    QUOTA bigint DEFAULT 0 NOT NULL,
    "USAGE" bigint DEFAULT 0 NOT NULL,
    MAX_SIZE bigint DEFAULT 0 NOT NULL,
    MAX_AGGR_COUNT bigint DEFAULT 0 NOT NULL,
    MAX_AGGR_SIZE bigint DEFAULT 0 NOT NULL,
    MAX_HISTORY_COUNT bigint DEFAULT 0 NOT NULL,
    GMT_CREATE timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    GMT_MODIFIED timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    CONSTRAINT GROUP_CAPACITY_PKEY PRIMARY KEY (ID),
    CONSTRAINT GROUP_CAPACITY_UK_GROUP_ID_KEY UNIQUE (GROUP_ID)
);

/******************************************/
/*   表名称 = his_config_info              */
/******************************************/
CREATE TABLE HIS_CONFIG_INFO
(
    ID numeric(20,0) NOT NULL,
    NID bigint NOT NULL AUTO_INCREMENT,
    DATA_ID character varying(255) NOT NULL,
    GROUP_ID character varying(128) NOT NULL,
    APP_NAME character varying(128) ,
    "CONTENT" clob NOT NULL,
    MD5 character varying(32) ,
    GMT_CREATE timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    GMT_MODIFIED timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    SRC_USER clob ,
    SRC_IP character varying(50) ,
    OP_TYPE character(10) ,
    TENANT_ID character varying(128) DEFAULT '' ,
    ENCRYPTED_DATA_KEY clob NOT NULL,
    CONSTRAINT HIS_CONFIG_INFO_PKEY PRIMARY KEY (NID)
);


/******************************************/
/*   表名称 = tenant_capacity              */
/******************************************/
CREATE TABLE TENANT_CAPACITY
(
    ID bigint NOT NULL AUTO_INCREMENT,
    TENANT_ID character varying(128) DEFAULT '' NOT NULL,
    QUOTA bigint DEFAULT 0 NOT NULL,
    "USAGE" bigint DEFAULT 0 NOT NULL,
    MAX_SIZE bigint DEFAULT 0 NOT NULL,
    MAX_AGGR_COUNT bigint DEFAULT 0 NOT NULL,
    MAX_AGGR_SIZE bigint DEFAULT 0 NOT NULL,
    MAX_HISTORY_COUNT bigint DEFAULT 0 NOT NULL,
    GMT_CREATE timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    GMT_MODIFIED timestamp without time zone DEFAULT (NOW())::timestamp(6) without time zone NOT NULL,
    CONSTRAINT TENANT_CAPACITY_PKEY PRIMARY KEY (ID),
    CONSTRAINT TENANT_CAPACITY_UK_TENANT_ID_KEY UNIQUE (TENANT_ID)
);


CREATE TABLE TENANT_INFO
(
    ID bigint NOT NULL AUTO_INCREMENT,
    KP character varying(128) NOT NULL,
    TENANT_ID character varying(128) DEFAULT '' ,
    TENANT_NAME character varying(128) DEFAULT '' ,
    TENANT_DESC character varying(256) ,
    CREATE_SOURCE character varying(32) ,
    GMT_CREATE bigint NOT NULL,
    GMT_MODIFIED bigint NOT NULL,
    CONSTRAINT TENANT_INFO_PKEY PRIMARY KEY (ID),
    CONSTRAINT TENANT_INFO_UK_TENANT_INFO_KPTENANTID_KEY UNIQUE (KP, TENANT_ID)
);

CREATE TABLE USERS
(
    USERNAME character varying(50) NOT NULL,
    "PASSWORD" character varying(500) NOT NULL,
    ENABLED smallint NOT NULL,
    CONSTRAINT USERS_PK PRIMARY KEY (USERNAME)
);

CREATE TABLE ROLES
(
    USERNAME character varying(50) NOT NULL,
    "ROLE" character varying(50) NOT NULL,
    CONSTRAINT ROLES_IDX_USER_ROLE_KEY UNIQUE (USERNAME, "ROLE")
);

CREATE TABLE PERMISSIONS
(
    "ROLE" character varying(50) NOT NULL,
    "RESOURCE" character varying(128) NOT NULL,
    "ACTION" character varying(8) NOT NULL,
    CONSTRAINT PERMISSIONS_UK_ROLE_PERMISSION_KEY UNIQUE ("ROLE", "RESOURCE", "ACTION")
);

INSERT INTO "USERS" ( "USERNAME", "PASSWORD", "ENABLED" ) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO "ROLES" ( "USERNAME", "ROLE" ) VALUES ('nacos', 'ROLE_ADMIN');