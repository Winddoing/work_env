#!/bin/bash
##########################################################
# Copyright (C) 2025 wqshao All rights reserved.
#  File Name    : ollama_translator.sh
#  Author       : wqshao
#  Created Time : 2025-08-06 13:59:52
#  Description  :
##########################################################

input_text=$1

#echo "input_text=[$input_text]"

#curl -s http://localhost:11434/api/generate -d '{
#  "model": "gemma3n-e4b-translator",
#  "prompt": "hello",
#  "stream": false
#}' | jq -r '.response'

echo -n "gemma3n:e4b: "
curl -s http://localhost:11434/api/generate -d "$(jq -n \
  --arg model "gemma3n-e4b-translator" \
  --arg prompt "$input_text" \
  '{model: $model, prompt: $prompt, stream: false}')" | jq -r '.response'

echo -n "qwen3:4b: "
curl -s http://localhost:11434/api/generate -d "$(jq -n \
  --arg model "qwen3-4b-translator" \
  --arg prompt "$input_text" \
  '{model: $model, prompt: $prompt, stream: false}')" | jq -r '.response'
