#!/bin/bash

echo "Ollama動作テスト開始..."

# PATHにOllamaを追加（念のため）
export PATH="/usr/local/bin:$PATH"

# Ollamaコマンド存在確認
if ! command -v ollama &> /dev/null; then
    echo "Ollamaがインストールされていません"
    exit 1
fi

# Ollamaサーバー確認
echo "1. Ollamaサーバー状態確認"
if curl -s http://localhost:11434/api/version; then
    echo " Ollama API応答正常"
else
    echo " Ollama API応答なし"
    exit 1
fi

# インストール済みモデル確認
echo -e "\n2. インストール済みモデル一覧"
ollama list

# モデル動作テスト
echo -e "\n3. モデル動作テスト"

echo "Graniteテスト（コード生成）:"
timeout 30s ollama run granite3.3:2b "Write a simple Python function to add two numbers" || echo "タイムアウト"

echo -e "\n埋め込みモデルテスト:"
timeout 20s ollama run nomic-embed-text "test embedding" || echo "タイムアウト"

echo -e "\nテスト完了"
echo "準備完了です！"