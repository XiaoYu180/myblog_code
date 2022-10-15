---
title: Mac第三方app无法打开解决方法
date: 2022-07-20 09:32:47
permalink: /pages/873337/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
# Mac第三方app无法打开解决方法



```shell
sudo xattr -r -d com.apple.quarantine 你的app
sudo spctl --master-disable
sudo codesign --force --deep --sign - 你的app
```

