#!/usr/bin/python3
# -*- coding:utf-8 -*-

#  File Name    : gd_translator.py
#  Author       : wqshao
#  Created Time : 2023-12-31 11:49:03
#  Description  :
# 翻译API key 保存在HOME目录下的.goldendict
# 格式：

# 在文件最下方通过注释的方式选择开启或关闭翻译引擎
import json
import requests
import random
from hashlib import md5
import time
import sys
import io
import threading
import os
import yaml

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

sys_home = os.environ.get("HOME")
goldendict = "/.goldendict"
yaml_name = "/.api_key.yaml"
config_file = sys_home + goldendict + yaml_name
configs = yaml.safe_load(open(config_file))

# print(sys_home)
# print(configs)

# api key

# 彩云小译
# print(configs["caiyunxiaoyi"]["key"])
caiyunxiaoyiKey = ""

# 百度翻译
# print(configs["baidu"]["id"], configs["baidu"]["secret"])
# print(configs["baidu"])
# baiduKey={"id":"xxx","secret":"123"}
baiduKey = configs["baidu"]
# print(baiduKey)

css = """<style type="text/css">
.engine {
  font-family: "MiSansVF";
  font-size: 18px;
  color: #578bc5;
}
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
    font-size: 16px;
}
</style>"""

def output_header(gd_word):
    print(css)
    print('<div class="originalText">' + gd_word + "</div>")
    print("<br><br>")


def output_body(engineName: str, definition: str):
    print('<span class="engine">' + engineName + "</span>")
    print('<div class="frame">')
    print("<definition>" + definition + "</definition>")
    print("</div>")
    print("<br>")


# 质量低，但能用
def YoudaoPublicBackup(gd_word):
    md = md5()
    lts = str(int(time.time() * 1000))
    salt = lts + str(random.randrange(10))
    md.update(
        "fanyideskweb{}{}Tbh5E8=q6U3EXe+&L[4c@".format(gd_word, salt).encode(
            "utf8"
        )
    )
    sign = md.hexdigest()
    url = "http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule"
    data = {
        "i": gd_word,
        "from": "AUTO",
        "to": "zh-CHS",
        "smartresult": "dict",
        "client": "fanyideskweb",
        "salt": salt,
        "sign": sign,
        "lts": lts,
        "bv": "1744f6d1b31aab2b4895998c6078a934",
        "doctype": "json",
        "version": "2.1",
        "keyfrom": "fanyi.web",
        "action": "FY_BY_REALTlME",
    }
    content = ""
    try:
        response = requests.post(
            url,
            headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.67 Safari/537.36",
                "Referer": "https://fanyi.youdao.com/",
                "Host": "fanyi.youdao.com",
                "Origin": "https://fanyi.youdao.com",
                "Cache-Control": "no-cache",
                "Connection": "keep-alive",
            },
            data=data,
        )
        trans = response.json()["translateResult"][0]
        for val in trans:
            content += val["tgt"]
    except Exception:
        content = "失败"
    output_body("有道翻译(public)", content)


def Youdao(gd_word):
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
        "q": gd_word,
        "from": "Auto",
        "to": "Auto",
    }
    try:
        output_body(
            "有道翻译",
            requests.post(
                "https://aidemo.youdao.com/trans", headers=headers, data=data
            ).json()["translation"][0],
        )
    except:
        output_body("有道翻译", "错误")


def Google(gd_word):
    definition = ""
    try:
        for x in requests.get(
            "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&q="
            + gd_word,
            headers={
                "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0)"
            },
        ).json()[0]:
            if x[0]:
                definition += x[0]
        output_body("谷歌翻译", definition)
    except:
        output_body("谷歌翻译", "错误")


def Caiyun():
    global caiyunxiaoyiKey
    payload = {
        "source": gd_word,
        "trans_type": "auto2zh",
        "request_id": "demo",
        "detect": True,
    }
    headers = {
        "content-type": "application/json",
        "x-authorization": "token " + caiyunxiaoyiKey,
    }
    try:
        output_body(
            "彩云小译",
            json.loads(
                requests.post(
                    "http://api.interpreter.caiyunai.com/v1/translator",
                    data=json.dumps(payload),
                    headers=headers,
                ).text
            )["target"],
        )
    except Exception as e:
        output_body("彩云小译", "错误:" + str(e))


def Baidu(gd_word):
    global baiduKey
    salt = random.randint(32768, 65536)
    # s = baiduKey["id"] + gd_word + str(salt) + baiduKey["secret"]
    s = str(baiduKey["id"]) + gd_word + str(salt) + str(baiduKey["secret"])
    sign = md5(s.encode("utf-8")).hexdigest()
    try:
        output_body(
            "百度翻译",
            requests.post(
                "http://api.fanyi.baidu.com/api/trans/vip/translate",
                params={
                    "appid": baiduKey["id"],
                    "q": gd_word,
                    "from": "auto",
                    "to": "zh",
                    "salt": salt,
                    "sign": sign,
                },
            ).json()["trans_result"][0]["dst"],
        )
    except Exception as e:
        output_body("百度翻译", "错误" + str(e))


def content_filter(gd_word):
    threads = []
    # threads.append(threading.Thread(target=Caiyun, args=(gd_word,)))
    threads.append(threading.Thread(target=Baidu, args=(gd_word,)))
    # threads.append(threading.Thread(target=Youdao, args=(gd_word,)))
    # threads.append(threading.Thread(target=YoudaoPublicBackup, args=(gd_word,)))

    output_header(gd_word)
    if len(gd_word.split()) >= 2:
        # print('gd_word 大于等于2')
        for t in threads:
            t.start()
    else:
        # print('gd_word 小于2，不翻译')
        print("^_^")
    return ""


if __name__ == "__main__":
    content_filter(sys.argv[1])
