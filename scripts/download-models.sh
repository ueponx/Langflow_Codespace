#!/bin/bash

echo "追加モデルをダウンロード中..."

# 全モデルリスト
MODELS=(
    "granite3.3:2b"
    "nomic-embed-text"
)

# プログレス表示付きダウンロード
for i in "${!MODELS[@]}"; do
    model="${MODELS[$i]}"
    echo "[$((i+1))/${#MODELS[@]}] ダウンロード中: $model"
    ollama pull "$model"
    echo "完了: $model"
    echo ""
done

echo "全モデルダウンロード完了！"
ollama list