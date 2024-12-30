#!/usr/bin/python3
# -*- coding:utf-8 -*-

#  File Name    : baidu_fanyi.py
#  Author       : wqshao
#  Created Time : 2023-12-31 20:31:08
#  Description  :
# Goldendict:
#   程序： html  /home/wq/.work_env/tools/script/baidu_fanyi.py %GDWORD%
# 翻译API key 保存在HOME目录下.goldendict的.api_key.yaml文件中
# 格式：
# baidu:
#    id: 123
#    secret: abc

# coding: utf8

import http.client
import hashlib
import json
import urllib
import random
import sys
import os
import yaml

# DEBUG = True
DEBUG = False

sys_home = os.environ.get("HOME")
goldendict = "/.config/goldendict/"
yaml_name = "/.api_key.yaml"
config_file = sys_home + goldendict + yaml_name
try:
    configs = yaml.safe_load(open(config_file))
except Exception as e:
    print(e)
    raise

# print(sys_home)
# print(configs)

# 百度翻译
# print(configs["baidu"]["id"], configs["baidu"]["secret"])
# print(configs["baidu"])
# baidu_api_key={"id":"xxx","secret":"123"}
baidu_api_key = configs["baidu"]

if DEBUG:
    print(baidu_api_key)
    print("<br>")

css = """<style type="text/css">
.originalText {
    font-size: 120%;
    font-family: "MiSansVF";
    font-weight: 600;
    display: inline-block;
    margin: 0rem 0rem 0rem 0rem;
    color: #2a5598;
    margin-bottom: 0.6rem;
}
.frame {
    margin: 1rem 0.5rem 0.5rem 0;
    padding: 0.7rem 0.5rem 0.5rem 0;
    border-top: 3px dashed #eaeef6;
}
definition {
    font-family: "MiSansVF";
    color: #2a5598;
    height: 120px;
    padding: 0.05em;
    font-weight: 500;
    font-size: 14px;
}
</style>"""


def output(orig_text: str, trans_text: str):
    print(css)
    print('<div class="originalText">' + orig_text + "</div>")
    print("<br>")

    print('<div class="frame">')
    print("<definition>" + trans_text + "</definition>")
    print("</div>")
    print("<br>")


def content_baidu_translate(content):
    """
    百度翻译官方提示的方法
    """
    appid = str(baidu_api_key["id"])  # 填写你的appid
    secretKey = str(baidu_api_key["secret"])  # 填写你的密钥
    httpClient = None
    myurl = "/api/trans/vip/translate"
    q = content
    fromLang = "en"  # 源语言
    toLang = "zh"  # 翻译后的语言
    salt = random.randint(32768, 65536)
    sign = appid + q + str(salt) + secretKey
    sign = hashlib.md5(sign.encode()).hexdigest()
    myurl = (
        myurl
        + "?appid="
        + appid
        + "&q="
        + urllib.parse.quote(q)
        + "&from="
        + fromLang
        + "&to="
        + toLang
        + "&salt="
        + str(salt)
        + "&sign="
        + sign
    )
    # print(myurl)

    try:
        httpClient = http.client.HTTPConnection("api.fanyi.baidu.com")
        httpClient.request("GET", myurl)
        # response是HTTPResponse对象
        response = httpClient.getresponse()
        jsonResponse = response.read().decode("utf-8")  # 获得返回的结果，结果为json格式
        js = json.loads(jsonResponse)  # 将json格式的结果转换字典结构
        # print(jsonResponse)

        content_print_byformat(js)  # 打印结果
    except Exception as e:
        print(e)
    finally:
        if httpClient:
            httpClient.close()


def content_print_byformat(js):
    """
    控制打印格式
    参考资料 http://api.fanyi.baidu.com/doc/21
    """

    orig_text_list = []
    for obj in js["trans_result"]:
        # print(obj['src'])
        text = obj["src"]
        orig_text_list.append(text)

    if DEBUG:
        print(orig_text_list)
        print("<br>")

    trans_text_list = []
    for obj in js["trans_result"]:
        # print(obj['dst'])
        text = obj["dst"]
        trans_text_list.append(text)

    if DEBUG:
        print(trans_text_list)
        print("<br>")

    output("".join(orig_text_list), "".join(trans_text_list))

    pass


def content_filter_word(content):
    """
    过滤内容
    """
    bb = content

    if DEBUG:
        print("----------------------------原始数据------------------------------")
        print("<br>")
        print(repr(bb))
        print("<br>")
        print("------------------------------------------------------------------")
        print("<br>")

    # 过滤规则1, 将所有回车换行符替换为空格
    if "\r\n" in bb:
        bb = bb.replace("\r\n", " ")

    # 过滤规则2, 将所有换行符替换为空格
    if "\n" in bb:
        bb = bb.replace("\n", " ")

    if DEBUG:
        print("==========================过滤后数据==============================")
        print("<br>")
        print(repr(bb))
        print("<br>")
        print("==================================================================")
        print("<br>")

    content_baidu_translate(bb)
    pass


def content_filter_len(content):
    """
    只翻译短语或者长句，不翻译单词
    """
    if len(content.split()) >= 2:
        # print('content大于等于2')
        content_filter_word(content)
    # else:
    #    # print('content小于2，不翻译')
    #    print("^_^")
    pass


def baidu_translate_goldendict(content):
    """
    主方法
    """
    content_filter_len(content)
    pass


if __name__ == "__main__":
    word = sys.argv[1]
    if len(word) > 500:
        baidu_translate_goldendict(word)
