#!/bin/bash
set -e

echo "Langflow + Ollama + Granite 環境をセットアップ中..."

# 作業ディレクトリ確認（カレントディレクトリを使用）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
cd "$REPO_DIR"

echo "作業ディレクトリ: $(pwd)"

# Pythonパッケージインストール
echo "Pythonパッケージをインストール中..."
pip install --upgrade pip
pip install -r requirements.txt

# SQLite問題の解決（Chroma用）
echo "SQLite設定中..."
# pysqlite3のシンボリックリンク作成
python3 -c "
import sqlite3
print('Current SQLite version:', sqlite3.sqlite_version)
"

# SQLite3の問題を回避するための設定
python3 -c "
import sys
import pysqlite3
sys.modules['sqlite3'] = pysqlite3
print('SQLite3 module replaced with pysqlite3')
"

# Ollamaインストール
echo "Ollamaをインストール中..."
curl -fsSL https://ollama.ai/install.sh | sh

# PATHにOllamaを追加
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
export PATH="/usr/local/bin:$PATH"

# Ollamaサービス確認
echo "Ollamaインストール確認..."
which ollama || echo "Ollama not found in PATH"

# Ollama起動（バックグラウンド）
echo "Ollamaサーバーを起動中..."
nohup ollama serve > ollama.log 2>&1 &
sleep 20  # サーバー起動待機

# 環境変数設定
echo "環境変数を設定中..."
export OLLAMA_HOST=http://localhost:11434

# Ollamaが起動しているか確認
echo "Ollama API確認中..."
for i in {1..10}; do
    if curl -s http://localhost:11434/api/version > /dev/null; then
        echo "Ollama API起動確認"
        break
    fi
    echo "待機中... ($i/10)"
    sleep 3
done

# 基本モデルダウンロード
echo "基本モデルをダウンロード中..."
ollama pull granite3.3:2b
ollama pull nomic-embed-text

# フォルダ構成確認
echo "フォルダ構造を確認中..."
ls -la flows/ data/ scripts/ 2>/dev/null || echo "一部のフォルダが見つかりません"

# 動作確認
echo "基本動作を確認中..."
if [ -f scripts/test-ollama.sh ]; then
    bash scripts/test-ollama.sh
else
    echo "test-ollama.sh が見つかりません。手動で動作確認してください。"
    # 簡易確認
    echo "簡易動作確認:"
    ollama list
fi

echo "セットアップ完了！"
echo "次の手順:"
echo "1. bash scripts/start-langflow.sh でLangflow起動"
echo "2. Portsタブから7860ポートにアクセス"
echo "3. docs/handson-guide.md を参照してハンズオン開始"