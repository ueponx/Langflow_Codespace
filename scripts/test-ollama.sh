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

# Graniteモデル動作テスト
echo -e "\n3. Graniteモデル動作テスト"
echo "コード生成テスト:"
timeout 30s ollama run granite3.3:2b "Write a simple Python function to add two numbers" || echo "タイムアウト"

# 埋め込みモデル確認（生成テストはスキップ）
echo -e "\n4. 埋め込みモデル確認"
if ollama list | grep -q "nomic-embed-text"; then
    echo "nomic-embed-text: インストール済み（RAG用埋め込みモデル）"
else
    echo "nomic-embed-text: 未インストール"
fi

echo -e "\nテスト完了"
echo "準備完了です！"