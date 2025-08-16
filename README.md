# langflow-ollama-codespaces 開発環境

**Langflow** + **Ollama**（**IBM Granite**）を使ったアプリケーション構築用のGitHub Codespaces（以下Codespaces）の環境となります。

## クイックスタート

### 1. **Codespaces**で開く

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/ueponx/langflow-ollama-codespaces)

### 2. 自動セットアップ完了を待つ

**Codespaces**が起動すると自動で以下が実行されます。

- **Langflow** + 依存関係インストール
- **Ollama** インストール・起動
- **LLMモデルダウンロード**（granite3.3:2b, nomic-embed-text）

所要時間: 約10分（初回はモデルのダウンロードがあるためかなり時間がかかります。完了までお待ちください。）

### 3. **Langflow**起動

設定が完了したら以下のコマンドを実行して**Langflow**を起動します。

```bash
bash scripts/start-langflow.sh
```
### 4. 開始

`Ports`タブの`port 7860`をクリックして、ブラウザで**Langflow**にアクセスしてください。

#### 開発者向け情報

- **Langflow**環境セットアップスクリプト　scripts/setup.sh
- **Ollama**動作テストスクリプト　scripts/test-ollama.sh
- モデルダウンロードスクリプト　scripts/download-models.sh