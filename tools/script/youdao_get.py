#!/usr/bin/python3
# -*- coding:utf-8 -*-

#  File Name    : youdao_get.py
#  Author       : wqshao
#  Created Time : 2022-07-26 09:23:14
#  Description  : GoldenDict翻译程序
#   程序： html  /home/wq/.work_env/tools/script/youdao_get.py %GDWORD%


header={
    'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Accept-Encoding':'gzip, deflate',
    'Accept-Language':'zh-CN,zh;q=0.8',
    "User-Agent":'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36',
    'Connection':'keep-alive',
    'Cookie':'myusername=2014211815; username=2014211815; smartdot=101590',
    'Upgrade-Insecure-Requests':'1'
}

import requests
import urllib
# from urllib import request
from lxml import etree
from sys import argv

if __name__ == "__main__":
    # r = requests.get(url,headers=header)

    url = 'http://dict.youdao.com/w/eng/{}/#keyfrom=dict2.index'
    word = argv[1]
    word = word.replace("/", "／")
    word = urllib.parse.quote(word)
    turl = url.format(word)
    #turl = urllib.parse.quote(turl, safe='/:?=')

    with requests.get(turl,headers=header) as f:
        data = f.text
        selector = etree.HTML(data)
        content = selector.xpath("//div[@id='results-contents']")[0]
        content = etree.tostring(content, encoding='utf-8', method='html')
        print(content.decode('utf-8'))
