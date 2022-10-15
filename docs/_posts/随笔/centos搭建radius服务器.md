---
title: centos搭建radius服务器
date: 2022-08-05 15:10:50
permalink: /pages/4fbf41/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
## 安装radius

```shell
yum install -y freeradius-utils freeradius
```

部署完成 ，启动FreeRadius调试模式。

```shell
radiusd -X
```

如果没有报错，就启动成功了

## 添加用户

```shell
vim users
```

```
#"John Doe"     Auth-Type := Local, User-Password == "hello"
#               Reply-Message = "Hello, %u"

改为

"test"  Auth-Type := Local, User-Password == "123456"
                Reply-Message = "Hello, %u"
```

## 测试连接

```shell
radtest test 123456 127.0.0.1 0 testing123
```

终端返回：
```
Sending Access-Request of id 161 to 127.0.0.1 port 1812
        User-Name = "test"
        User-Password = "123456"
        NAS-IP-Address = 255.255.255.255
        NAS-Port = 0
rad_recv: Access-Accept packet from host 127.0.0.1:1812, id=161, length=33
        Reply-Message = "Hello, test"
```

## 权限访问

```
cd /etc/raddb
cp client.conf client.conf.back
vim client.conf

增加
client 192.168.1.0/24 {
       secret      = 123456
       shortname   = any
}

```

## 命令

```
service radiusd start
service radiusd enable
```