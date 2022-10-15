---
title: 自动根据chrome版本下载webdriver
date: 2022-07-25 17:45:27
permalink: /pages/c5da2a/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
我们在使用selenium时，有一件让我们狠抓狂的事，那就是驱动的下载与配置…
为什么这么说呢？

> 1）首先确定浏览器对应的驱动版本号
> 2）然后手动下载下来
> 3）最后配置驱动路径或放在对应的目录下

使用toollib就很方便，这些都内部处理好了。（pip install toollib）
示例代码如下：

```python
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from toollib import autodriver

driver_path = autodriver.chromedriver()  # 自动下载驱动
driver = webdriver.Chrome(service=Service(driver_path))
driver.get('https://www.baidu.com')
driver.find_element(value='kw').send_keys('python toollib')
driver.find_element(value='su').click()
time.sleep(29)
driver.close()
```

