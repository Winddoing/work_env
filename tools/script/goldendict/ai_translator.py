#!/usr/bin/python3
# -*- coding:utf-8 -*-

#  File Name    : ai_translator.py
#  Author       : wqshao
#  Created Time : 2025-10-31 10:31:33
#  Description  :
#    sudo apt install python3-openai

import os
from openai import OpenAI

def translate_english_to_chinese(url, key, model_name, english_text): 
    # 初始化客户端，确保api_key和base_url正确
    client = OpenAI(
            api_key=key,  # 请替换为你的真实API密钥
            base_url=url
            )

    try:
        # 尝试调用API
        response = client.chat.completions.create(
                model=model_name,  # 请使用你确认可用的模型
                messages=[
                    {
                        "role": "system",
                        "content": "你是一个专业的翻译助手，擅长将英文准确、流畅地翻译成中文。"
                        },
                    {
                        "role": "user",
                        "content": f"请将以下英文翻译成中文：\n{english_text}"
                    }
                ],
                temperature=0.1  # 低温度使输出更确定，适合翻译任务
            )

        # 打印翻译结果
        translated_text = response.choices[0].message.content
        print("翻译成功！")
        print(f"原文: {english_text}")
        print(f"译文: {translated_text}")
        return translated_text

    except Exception as e:
        print(f"翻译过程中出现错误: {e}")

# 示例使用
if __name__ == "__main__":

    # 需要翻译的英文文本
    english_text = "Hello, world! This is a test of the translation API."

    print("待翻译原文:")
    print(english_text)
    print("\n翻译结果:")

    # 调用翻译函数
    siliconflow_key = os.environ.get("SILICONFLOW_API_KEY")
    print(siliconflow_key)
    #result = translate_english_to_chinese("https://api.siliconflow.cn/v1", siliconflow_key, "deepseek-ai/DeepSeek-V2.5", english_text)
    #result = translate_english_to_chinese("https://api.siliconflow.cn/v1", siliconflow_key, "deepseek-ai/DeepSeek-V3", english_text)
    #result = translate_english_to_chinese("https://api.siliconflow.cn/v1", siliconflow_key, "deepseek-ai/DeepSeek-V3.1-Terminus", english_text)
    #result = translate_english_to_chinese("https://api.siliconflow.cn/v1", siliconflow_key, "deepseek-ai/DeepSeek-R1", english_text)
    result = translate_english_to_chinese("http://localhost:11434/v1", "ollama", "qwen3:1.7b", english_text)

    # https://help.aliyun.com/zh/model-studio/compatibility-of-openai-with-dashscope
    #qwen_key = os.environ.get("QWEN_API_KEY")
    #print(qwen_key)
    #result = translate_english_to_chinese("https://dashscope.aliyuncs.com/compatible-mode/v1", qwen_key, "qwen-max", english_text)

    print(result)

