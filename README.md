# Langflow + Ollama + Granite 環境

Ollama + IBM Graniteを使ったLangflowアプリケーション構築のための環境です。

## クイックスタート

### 1. Codespacesで開く
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/your-username/langflow-ollama-granite)

### 2. 自動セットアップ完了を待つ
Codespacesが起動すると自動で以下が実行されます：
- Langflow + 依存関係インストール
- Ollama インストール・起動
- 基本LLMモデルダウンロード（granite3.3:2b, nomic-embed-text）

所要時間: 約5-10分

### 3. Langflow起動
```bash
bash scripts/start-langflow.sh
```
### 4. 開始
「Ports」タブの7860をクリックしてLangflowにアクセス後、
実施ガイドに従って進めてください。

#### ドキュメント

- 実施ガイド - 実際の学習手順
- Ollama設定詳細 - 詳細設定方法
- トラブルシューティング - 問題解決

#### 内容

1. Ollama基本操作 - ローカルLLM環境の理解
2. Langflow + Ollama連携 - ノーコードAI開発
3. コード生成システム - Graniteの活用
4. RAGシステム構築 - 文書検索AI作成

#### 管理者向け情報

- セットアップスクリプト: scripts/setup.sh
- トラブルシューティング: scripts/test-ollama.sh
- モデル管理: scripts/download-models.sh