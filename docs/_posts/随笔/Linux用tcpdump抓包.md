---
title: Linux用tcpdump抓包
date: 2022-07-18 21:01:19
permalink: /pages/2441df/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
# Linux用tcpdump抓包



> 网络数据包截获分析工具。支持针对网络层、协议、主机、网络或端口的过滤。并提供and、or、not等逻辑语句帮助去除无用的信息。



### 不指定任何参数

监听第一块网卡上经过的数据包。主机上可能有不止一块网卡，所以经常需要指定网卡。

```powershell
tcpdump
```

### 监听特定网卡

```powershell
tcpdump -i en0
```

### 监听特定主机

例子：监听本机跟主机`182.254.38.55`之间往来的通信包。

备注：出、入的包都会被监听。

```bash
tcpdump host 182.254.38.55
```

### 特定来源、目标地址的通信

特定来源

```bash
tcpdump src host hostname
```

特定目标地址

```bash
tcpdump dst host hostname
```

如果不指定`src`跟`dst`，那么来源 或者目标 是hostname的通信都会被监听

```bash
tcpdump host hostname
```

### 特定端口

```bash
tcpdump port 3000
```

### 监听TCP/UDP

服务器上不同服务分别用了TCP、UDP作为传输层，假如只想监听TCP的数据包

```bash
tcpdump tcp
```

### 来源主机+端口+TCP

监听来自主机`123.207.116.169`在端口`22`上的TCP数据包

```bash
tcpdump tcp port 22 and src host 123.207.116.169
```

### 监听特定主机之间的通信

```powershell
tcpdump ip host 210.27.48.1 and 210.27.48.2
```

`210.27.48.1`除了和`210.27.48.2`之外的主机之间的通信

```armasm
tcpdump ip host 210.27.48.1 and ! 210.27.48.2
```

### 稍微详细点的例子

```powershell
tcpdump tcp -i eth1 -t -s 0 -c 100 and dst port ! 22 and src net 192.168.1.0/24 -w ./target.cap
```

> (1)tcp: ip icmp arp rarp 和 tcp、udp、icmp这些选项等都要放到第一个参数的位置，用来过滤数据报的类型
> (2)-i eth1 : 只抓经过接口eth1的包
> (3)-t : 不显示时间戳
> (4)-s 0 : 抓取数据包时默认抓取长度为68字节。加上-S 0 后可以抓到完整的数据包
> (5)-c 100 : 只抓取100个数据包
> (6)dst port ! 22 : 不抓取目标端口是22的数据包
> (7)src net 192.168.1.0/24 : 数据包的源网络地址为192.168.1.0/24
> (8)-w ./target.cap : 保存成cap文件，方便用ethereal(即wireshark)分析



### 限制抓包的数量

如下，抓到1000个包后，自动退出

```bash
tcpdump -c 1000
```

### 保存到本地

备注：tcpdump默认会将输出写到缓冲区，只有缓冲区内容达到一定的大小，或者tcpdump退出时，才会将输出写到本地磁盘

```bash
tcpdump -n -vvv -c 1000 -w /tmp/tcpdump_save.cap
```

也可以加上`-U`强制立即写到本地磁盘（一般不建议，性能相对较差）