---
title: 通过Win10远程连接UOS-RDP
date: 2022-07-12 15:25:09
permalink: /pages/495030/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
# 通过Win10远程连接UOS-RDP.md



## 安装xrdp

```shell
sudo apt-get install xrdp
```



## 远程连接

- UOS下，输入sudo init 3
- windows下，打开远程桌面连接，输入UOS的ip、账号、密码



附：

1. xrdp的运行状态

   ```shell
   systemctl status xrdp
   ```

2. UOS查看ip

   ```shell
   ip addr
   ```

   