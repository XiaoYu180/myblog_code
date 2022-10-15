---
title: 将pem证书转换为crt、key
date: 2022-08-03 19:33:13
permalink: /pages/64ed14/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
1.pem转crt格式

```shell
openssl x509 -in fullchain.pem -out fullchain.crt
```

2.pem转key格式

```shell
openssl rsa -in privkey.pem -out privkey.key
```

