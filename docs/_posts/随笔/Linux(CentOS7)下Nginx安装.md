---
title: Linux(CentOS7)下Nginx安装
date: 2022-07-18 20:46:08
permalink: /pages/a049ff/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
# Linux(CentOS7)下Nginx安装



## 一、准备工作

**版本说明：**

- Linux版本：CentOS 7 64位
- Nginx版本：nginx-1.20.0



### 1. 下载安装文件

采用源码包方式安装，当然使用 yum 方式安装也可以，此处使用源码包安装。

进入目录(个人习惯/usr/local)，下载安装文件，如果云服务器下载速度过慢也可本地下载后上传。

```bash
cd /usr/local
wget http://nginx.org/download/nginx-1.20.0.tar.gz
```

### 2. 安装Nginx所需要的依赖

```bash
# 安装gcc、gcc-c++
yum -y install gcc
yum -y install gcc-c++

# 安装pcre 、zilb
yum -y install pcre*
yum -y install zlib*

# 安装openssl(若需要支持 https 协议)
yum -y install openssl
yum -y install openssl-devel
```

## 二、安装及配置Nginx

### 1. 安装Nginx

1、解压安装包。

```bash
tar -zxvf nginx-1.20.0.tar.gz
```

2、为编译安装做准备，进入解压目录。

```bash
cd nginx-1.20.0
```

3、为编译安装做准备。

```bash
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_stub_status_module --with-pcre
```

**注:** --prefix：设置安装路径。 --with-http_stub_status_module：支持nginx状态查询。 --with-http_ssl_module：支持https。 --with-pcre：为了支持rewrite重写功能，必须制定pcre。

4、编译安装。

```bash
make && make install
```

5、指定配置文件启动 Nginx。

```bash
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```

在浏览器访问 ip，看到如下信息则安装成功。

```text
Welcome to nginx!
If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```

### 2. 一些命令

修改自己的配置之后，验证配置是否正确，重启 Nginx 命令

```bash
# 进入目录
cd /usr/local/nginx/sbin

# 验证配置是否正确
./nginx -t
# 如果看到如下内容, 那么配置正确, 可以重启Nginx
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

# 重启Nginx, 之后就可以通过域名访问了, 哈哈
./nginx -s reload
```

### 3. Nginx开机自启

```text
# 新建文件
vim /lib/systemd/system/nginx.service

# 添加内容
[Unit]
Description=nginx.server
After=network.target

[Service]
Type=forking
PIDFILE=/var/run/nginx.pid
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecRepload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

然后使用 `systemctl enable nginx.service` 开启 nginx 开机自启，重启 CentOS 查看效果。

```bash
# 启动nginx服务
systemctl start nginx.service

# 停止nginx服务
systemctl stop nginx.service

# 重启nginx服务
systemctl restart nginx.service

# 查看nginx服务当前状态
systemctl status nginx.service

# 设置nginx服务开机自启动
systemctl enable nginx.service

# 停止nginx服务开机自启动
systemctl disable nginx.service
```



---

顺便记录下配置反向代理

我们可以通过 **proxy_pass** 来配置，找到nginx配置文件 nginx.conf

```text
server {
    listen       80;
    server_name  localhost;# 服务器地址或绑定域名

    location / { # 访问80端口后的所有路径都转发到 proxy_pass 配置的ip中
        root   /usr/share/nginx/html;
        index  index.html index.htm;
           proxy_pass https://192.168.1.205; 
    }
}
```



**修改完配置文件，需要重启nginx**