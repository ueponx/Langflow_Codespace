#!/bin/bash

echo "Langflow + Ollama起動シーケンス開始..."

# Ollamaサーバー確認・起動
echo "Ollamaサーバー状態確認..."
if ! pgrep -f "ollama serve" > /dev/null; then
    echo "Ollamaサーバーを起動中..."
    ollama serve &
    sleep 15
    echo "Ollamaサーバー起動完了"
else
    echo "Ollamaサーバー既に稼働中"
fi

# 環境変数設定
export OLLAMA_HOST=http://localhost:11434

# Ollamaの動作確認
echo "利用可能モデル一覧:"
ollama list

# Ollama API接続テスト
echo "Ollama API接続テスト..."
if curl -s http://localhost:11434/api/tags > /dev/null; then
    echo "Ollama API 正常稼働"
else
    echo "Ollama API エラー - 再起動中..."
    pkill -f "ollama serve"
    sleep 5
    ollama serve &
    sleep 15
fi

# Langflow起動
echo "Langflow起動中..."
echo "アクセスURL: http://localhost:7860"
langflow run --host 0.0.0.0 --port 7860 --load-flows-path ./flows

echo "起動完了！"
echo "アクセス情報:"
echo "  - Langflow UI: http://localhost:7860"
echo "  - Ollama API: http://localhost:11434"
echo "  - Codespacesの「Ports」タブからアクセスしてください"