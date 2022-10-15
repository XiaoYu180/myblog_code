---
title: 自建CA签发SSL证书（gnutls）
date: 2022-08-03 19:32:23
permalink: /pages/102a52/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
## 环境

系统：CentOS 7.8
 
## 安装

- 安装

  

  ```shell
  # yum install gnutls-utils
  ```

- 创建工作目录

  

  ```shell
  # mkdir /data/ssl
  # cd /data/ssl
  ```

## CA

- 创建CA模版

  

  ```shell
  # vim ca.tmpl
  cn = "Your CA name"
  organization = "Your organization name"
  serial = 1
  expiration_days = 3650
  ca
  signing_key
  cert_signing_key
  crl_signing_key
  ```

- 生成CA私钥

  

  ```shell
  # certtool --generate-privkey --outfile ca-key.pem
  ```

- 生成CA证书

  

  ```shell
  # certtool --generate-self-signed \
  --load-privkey ca-key.pem \
  --template ca.tmpl \
  --outfile ca-cert.pem
  ```

## Server密钥和证书

- 创建Server证书模版

  

  ```shell
  # vim server.tmpl
  cn = "Your hostname or IP" 
  organization = "Your organization name" 
  expiration_days = 3650
  signing_key 
  encryption_key
  tls_www_server
  ```

- 生成Server私钥

  

  ```shell
  # certtool --generate-privkey --outfile server-key.pem 
  ```

- 生成Server证书

  

  ```shell
  # certtool --generate-certificate \
  --load-privkey server-key.pem \
  --load-ca-certificate ca-cert.pem \
  --load-ca-privkey ca-key.pem \
  --template server.tmpl \
  --outfile server-cert.pem 
  ```

## Client密钥和证书

- 创建Client证书模版

  

  ```shell
  # vim client-zhangsan.tmpl
  cn = "zhangsan"
  unit = "zhangsan unit"  
  expiration_days = 3650
  signing_key  
  tls_www_client
  ```

- 生成Client私钥

  

  ```shell
  # certtool --generate-privkey --outfile client-zhangsan-key.pem 
  ```

- 生成Client证书

  

  ```shell
  # certtool --generate-certificate \
  --load-privkey client-zhangsan-key.pem \
  --load-ca-certificate ca-cert.pem \
  --load-ca-privkey ca-key.pem \
  --template client-zhangsan.tmpl \
  --outfile client-zhangsan-cert.pem 
  ```

- 转换为p12证书

  

  ```shell
  # openssl pkcs12 -export \
  -inkey client-zhangsan-key.pem \
  -in client-zhangsan-cert.pem \
  -certfile ca-cert.pem \
  -out client-zhangsan.p12
  ```



作者：袁先生的笔记
链接：https://www.jianshu.com/p/ab9523a6c0f4
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。