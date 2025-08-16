#!/bin/bash

echo "Langflow + Ollama起動シーケンス開始..."

# 作業ディレクトリ設定
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
cd "$REPO_DIR"

echo "作業ディレクトリ: $(pwd)"

# コマンド存在確認
if ! command -v ollama &> /dev/null; then
    echo "Ollamaがインストールされていません。先にsetup.shを実行してください。"
    echo "実行コマンド: bash scripts/setup.sh"
    exit 1
fi

if ! command -v langflow &> /dev/null; then
    echo "Langflowがインストールされていません。先にsetup.shを実行してください。"
    echo "実行コマンド: bash scripts/setup.sh"
    exit 1
fi

# PATHにOllamaを追加（念のため）
export PATH="/usr/local/bin:$PATH"

# Ollamaサーバー確認・起動
echo "Ollamaサーバー状態確認..."
if ! pgrep -f "ollama serve" > /dev/null; then
    echo "Ollamaサーバーを起動中..."
    nohup ollama serve > ollama.log 2>&1 &
    sleep 20
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
for i in {1..5}; do
    if curl -s http://localhost:11434/api/tags > /dev/null; then
        echo "Ollama API 正常稼働"
        break
    fi
    if [ $i -eq 5 ]; then
        echo "Ollama API エラー - 再起動中..."
        pkill -f "ollama serve"
        sleep 5
        nohup ollama serve > ollama.log 2>&1 &
        sleep 20
    fi
    echo "待機中... ($i/5)"
    sleep 3
done

# flowsディレクトリ確認
FLOWS_PATH="./flows"
if [ ! -d "$FLOWS_PATH" ]; then
    echo "flowsディレクトリが見つかりません。作成中..."
    mkdir -p "$FLOWS_PATH"
fi

# Langflow起動
echo "Langflow起動中..."
echo "アクセスURL: http://localhost:7860"
langflow run --host 0.0.0.0 --port 7860

echo "起動完了！"
echo "アクセス情報:"
echo "  - Langflow UI: http://localhost:7860"
echo "  - Ollama API: http://localhost:11434"
echo "  - Codespacesの「Ports」タブからアクセスしてください"