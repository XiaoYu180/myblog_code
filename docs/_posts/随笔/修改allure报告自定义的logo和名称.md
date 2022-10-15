---
title: 修改allure报告自定义的logo和名称
date: 2022-07-15 17:26:07
permalink: /pages/eacdad/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
# 修改allure报告自定义的logo和名称



1. 找到allure的安装路径

2. 放置logo到 `\plugins\custom-logo-plugin\static`下

   

![image-20220715172752755](../../.vuepress/public/img/blog/image-20220715172752755.png)

3. 修改`style.css` 文件

   ```css
   .side-nav__brand {
       background: url('custom-logo.png') no-repeat left center !important;
       margin-left: 10px;
       height: 50px;
       background-size: contain !important;
   }
   
   
   .side-nav__brand span{
   	display: none;
   }
   .side-nav__brand:after{
       content: "名字";
       margin-left: 20px;
   }
   ```

4. 进入 `\config` 文件夹，修改 `allure.yml`，追加

   ![image-20220715173143293](../../.vuepress/public/img/blog/image-20220715173143293.png)

   

   然后重新生成allure报告就可以看到修改后的效果了。