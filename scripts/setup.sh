#!/bin/bash
set -e

echo "Langflow + Ollama + Granite 環境をセットアップ中..."

# 作業ディレクトリ確認
cd /workspaces/langflow-ollama-granite

# Pythonパッケージインストール
echo "Pythonパッケージをインストール中..."
pip install --upgrade pip
pip install -r requirements.txt

# Ollamaインストール
echo "Ollamaをインストール中..."
curl -fsSL https://ollama.ai/install.sh | sh

# Ollama起動（バックグラウンド）
echo "Ollamaサーバーを起動中..."
ollama serve &
sleep 15  # サーバー起動待機

# 環境変数設定
echo "環境変数を設定中..."
export OLLAMA_HOST=http://localhost:11434

# 基本モデルダウンロード
echo "基本モデルをダウンロード中..."
ollama pull granite3.3:2b
ollama pull nomic-embed-text

# フォルダ構成確認
echo "フォルダ構造を確認中..."
ls -la flows/ data/ scripts/

# 動作確認
echo "基本動作を確認中..."
bash scripts/test-ollama.sh

echo "セットアップ完了！"
echo "次の手順:"
echo "1. bash scripts/start-langflow.sh でLangflow起動"
echo "2. Portsタブから7860ポートにアクセス"
echo "3. docs/handson-guide.md を参照してハンズオン開始"