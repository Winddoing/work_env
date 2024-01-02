#!/usr/bin/python3
# -*- coding:utf-8 -*-

#  File Name    : youdao_fanyi.py
#  Author       : wqshao
#  Created Time : 2024-01-02 17:26:29
#  Description  :

import sys
import requests
import re

DEBUG = False

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


def content_youdao_translate(content):
    headers = {
        "authority": "aidemo.youdao.com",
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "origin": "https://ai.youdao.com",
        "referer": "https://ai.youdao.com/",
        "sec-ch-ua": '"Chromium";v="106", "Microsoft Edge";v="106", "Not;A=Brand";v="99"',
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": '"Windows"',
        "sec-fetch-dest": "empty",
        "sec-fetch-mode": "cors",
        "sec-fetch-site": "same-site",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36 Edg/106.0.1370.47",
    }
    data = {
        "q": content,
        "from": "Auto",
        "to": "Auto",
    }
    try:
        res = requests.post(
            "https://aidemo.youdao.com/trans", headers=headers, data=data
        )

        # print(res)
        if DEBUG:
            print(res.text)
            print("----------------")
            print(res.json()["query"])
            print(res.json()["translation"][0])

        output(res.json()["query"], res.json()["translation"][0])

    except:
        print("错误")


def content_filter_word(content):
    """
    过滤内容
    """
    bb = content

    if DEBUG:
        print("------------------------------------------------------------------")
        print(repr(bb))
        print("------------------------------------------------------------------")

    # 过滤规则, 将所有回车换行符替换为空格
    if "\r\n" in bb:
        bb = bb.replace("\r\n", " ")

    if DEBUG:
        print("==================================================================")
        print(repr(bb))
        print("==================================================================")

    content_youdao_translate(bb)
    pass


def is_chinese(word):
    pattern = re.compile(r"[\u4e00-\u9fff]")
    return bool(pattern.search(word))


def content_filter_len(content):
    """
    只翻译短语或者长句，不翻译单词
    """
    if len(content.split()) >= 2:
        # print('content大于等于2')
        content_filter_word(content)
    else:
        # print('content小于2，不翻译')
        # print("^_^")
        if is_chinese(content):
            content_youdao_translate(content)
    pass


def baidu_translate_goldendict(content):
    """
    主方法
    """
    if DEBUG:
        print(content)

    content_filter_len(content)
    pass


if __name__ == "__main__":
    baidu_translate_goldendict(sys.argv[1])
