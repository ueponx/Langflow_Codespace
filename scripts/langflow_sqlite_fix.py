#!/usr/bin/env python3
"""
Langflowを起動するスクリプト
"""
import sys
import os

# 最初にpysqlite3でsqlite3を置き換え
__import__('pysqlite3')
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')

# 環境変数設定
os.environ['OLLAMA_HOST'] = 'http://localhost:11434'

# これでLangflowをインポート・実行
if __name__ == "__main__":
    from langflow.langflow_launcher import main
    
    # Langflowのコマンドライン引数を設定
    sys.argv = [
        'langflow',
        'run',
        '--host', '0.0.0.0',
        '--port', '7860'
    ]
    
    try:
        main()
    except KeyboardInterrupt:
        print("\nLangflow stopped by user")
    except Exception as e:
        print(f"Error starting Langflow: {e}")
        sys.exit(1)