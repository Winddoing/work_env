#!/usr/bin/python3
# -*- coding:utf-8 -*-

#  File Name    : bing_fanyi.py
#  Author       : wqshao
#  Created Time : 2025-08-01 14:28:38
#  Description  :

import requests
import re
import sys
import json
import time

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

    # 过滤规则, 将所有回车换行符替换为空格
    if "\r\n" in bb:
        bb = bb.replace("\r\n", " ")

    # 过滤规则, 将所有换行符替换为空格
    if "\n" in bb:
        bb = bb.replace("\n", " ")

    # 在字符串末尾添加英文句号
    bb += '.'

    if DEBUG:
        print("===========================过滤后数据=============================")
        print("<br>")
        print(repr(bb))
        print("<br>")
        print("==================================================================")
        print("<br>")

    return bb


def get_bing_translation(text):
    # Step 1: 获取必应翻译页面提取关键参数
    home_url = "https://cn.bing.com/translator"
    session = requests.Session()
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36 Edg/125.0.0.0",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"
    }

    # 获取首页内容
    home_response = session.get(home_url, headers=headers)
    if home_response.status_code != 200:
        raise Exception(f"Failed to load Bing Translator homepage (status: {home_response.status_code})")

    home_html = home_response.text

    # 调试：保存HTML到文件以便检查
    # with open("bing_translator.html", "w", encoding="utf-8") as f:
    #     f.write(home_html)

    # 提取IG参数
    ig_match = re.search(r'IG[":\s]+([A-F0-9]{32})', home_html, re.IGNORECASE)
    if not ig_match:
        ig_match = re.search(r'params_RichTranslateHelper[^;]+"([A-F0-9]{32})"\]', home_html, re.IGNORECASE)
        if not ig_match:
            # 尝试从您提供的格式中提取
            ig_match = re.search(r'IG:"([A-F0-9]{32})"', home_html, re.IGNORECASE)
            if not ig_match:
                raise Exception("Could not extract IG parameter")
    ig = ig_match.group(1)

    # 提取Token参数 - 根据您提供的格式进行修复
    token_match = re.search(r'var params_AbusePreventionHelper\s*=\s*\[(\d+),"(.*?)",(\d+)\];', home_html)
    if not token_match:
        # 尝试备用匹配模式
        token_match = re.search(r'AbusePreventionHelper\s*=\s*{\s*key:\s*"([^"]+)",\s*expire:\s*(\d+)', home_html)
        if token_match:
            timestamp = token_match.group(2)
            key = token_match.group(1)
        else:
            # 尝试更宽松的匹配
            token_match = re.search(r'params_AbusePreventionHelper\s*=\s*\[(\d+),\s*"([^"]+)",', home_html)
            if token_match:
                timestamp = token_match.group(1)
                key = token_match.group(2)
            else:
                raise Exception("Could not extract token parameter")
    else:
        timestamp = token_match.group(1)
        key = token_match.group(2)

    #print(f"Extracted parameters - IG: {ig}, Timestamp: {timestamp}, Key: {key}")  # 调试信息

    # Step 2: 构造翻译请求
    translate_url = f"https://cn.bing.com/ttranslatev3?isVertical=1&IG={ig}&IID=translator.5028.1"

    payload = {
        "fromLang": "auto-detect",
        "text": text,
        "to": "zh-Hans",
        "token": key,
        "key": timestamp
    }

    translate_headers = {
        **headers,
        "Content-Type": "application/x-www-form-urlencoded",
        "Referer": "https://cn.bing.com/translator",
        "Accept": "application/json",
        "X-Requested-With": "XMLHttpRequest"
    }

    # 添加延迟避免请求过快
    time.sleep(0.5)

    # 发送翻译请求
    #print("Sending translation request...")  # 调试信息
    response = session.post(
        translate_url,
        headers=translate_headers,
        data=payload
    )

    if response.status_code != 200:
        raise Exception(f"Translation failed with status code: {response.status_code}\nResponse: {response.text}")

    try:
        # 解析返回的JSON数据
        translation_data = response.json()

        # 调试信息 - 输出原始API响应
        #print("Raw API Response:", json.dumps(translation_data, indent=2, ensure_ascii=False))

        # 提取翻译结果 - 适配多种可能的响应结构
        if isinstance(translation_data, list) and len(translation_data) > 0:
            # 尝试第一种结构
            if "translations" in translation_data[0]:
                translations = translation_data[0].get("translations", [])
                if translations:
                    return translations[0].get("text", "")

            # 尝试第二种结构
            elif "text" in translation_data[0]:
                return translation_data[0].get("text", "")

            # 尝试第三种结构
            elif len(translation_data) > 1 and "translations" in translation_data[1]:
                translations = translation_data[1].get("translations", [])
                if translations:
                    return translations[0].get("text", "")

    except json.JSONDecodeError:
        pass

    raise Exception(f"Failed to parse translation response: {response.text}")

if __name__ == "__main__":
    input_text = sys.argv[1]
    #print(input_text)

    """
    只翻译短语或者长句，不翻译单词，单词直接返回
    """
    if len(input_text.split()) < 2:
        sys.exit(0)

    try:
        original_text = content_filter_word(input_text)
        translated_text = get_bing_translation(original_text)

        #print(f"Original: {original_text}")
        #print(f"Translation: {translated_text}")
        output(original_text, translated_text)
    except Exception as e:
        print(f"Error: {str(e)}")
        sys.exit(1)
