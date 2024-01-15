# Nacos数据库适配插件

## 一、插件概述

### 1.1、简介

从Nacos2.2版本开始，Nacos提供了数据源扩展插件，以便让需要进行其他数据库适配的用户自己编写插件来保存数据。当前项目插件目前已简单适配Postgresql。

如需Nacos2.1支持，请移步个人的如下这个仓库：

https://github.com/wuchubuzai2018/nacos-multidatasource

当前项目基于Nacos2.2版本的扩展插件口进行开发。

### 2.2、插件工程结构说明

nacos-datasource-plugin-ext-base工程为数据库插件操作的适配抽象。

nacos-all-datasource-plugin-ext工程可打包所有适配的数据库插件

nacos-postgresql-datasource-plugin-ext工程可打包适配Postgresql的数据库插件

## 二、下载和使用

### 2.1、插件引入

方式一：使用postgresql作为依赖引入到Nacos主分支源码中，例如：

```xml
<dependency>
            <groupId>com.alibaba.nacos</groupId>
            <artifactId>nacos-postgresql-datasource-plugin-ext</artifactId>
            <version>1.0.0-SNAPSHOT</version>
        </dependency>
```

方式二：下载当前插件项目源码，打包为jar包，将该文件的路径配置到startup.sh文件中，使用Nacos的loader.path机制指定该插件的路径，可修改startup.sh中的loader.path参数的位置进行指定。

### 2.2、修改数据库配置文件

在application.properties文件中声明postgresql的配置信息：

### postgresql
```java
spring.datasource.platform=postgresql
db.url.0=jdbc:postgresql://localhost:5432/nacos?tcpKeepAlive=true&reWriteBatchedInserts=true&ApplicationName=nacos_java
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=org.postgresql.Driver
db.pool.config.connectionTestQuery=SELECT 1
```

### 人大金仓
```java
spring.datasource.platform=kingbase
db.num=1
db.url.0=jdbc:kingbase8://localhost:54321/nacos
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=com.kingbase8.Driver
```

### mysql
```java
spring.datasource.platform=mysql
db.num=1
db.url.0=jdbc:mysql://localhost:3306/nacos?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true
db.user=nacos
db.password=nacos
```

### oracle
```java
spring.datasource.platform=oracle
db.num=1
db.url.0=jdbc:oracle:thin:@localhost:1521:orcl
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=oracle.jdbc.driver.OracleDriver
db.pool.config.connectionTestQuery=SELECT * FROM dual
```

### 达梦
```java
spring.datasource.platform=dm
db.num=1
db.url.0=jdbc:dm://localhost:5236/nacos?STU&zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=utf-8
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=dm.jdbc.driver.DmDriver
```

### 神通数据库
```java
spring.datasource.platform=oscar
db.num=1
db.url.0=jdbc:oscar://localhost:2003/nacos
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=com.oscar.Driver
```

### 瀚高数据库
```java
spring.datasource.platform=highgo
db.num=1
db.url.0=jdbc:highgo://localhost:5866/nacos
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=com.highgo.jdbc.Driver
```

### sqlserver
```java
spring.datasource.platform=sqlserver
db.num=1
db.url.0=jdbc:sqlserver://localhost:1433;databaseName=nacos;trustServerCertificate=true
db.user=nacos
db.password=nacos
db.pool.config.driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
```
