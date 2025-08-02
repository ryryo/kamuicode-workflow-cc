# セットアップガイド

このワークフローを使用するための初期設定手順です。

## 必要な環境

- Claude Code SDK
- Node.js (MCP サーバー用)
- Python 3.x (FAL アップロード用)
- ffmpeg (動画・音声処理用)

## ステップ 1: 設定ファイルの準備

### 1.1 環境変数ファイル

```bash
# .env.example を .env にコピー
cp .env.example .env

# エディタで .env を開いて、実際のAPIキーを入力
vi .env
```

### 1.2 MCP設定ファイル

```bash
# mcp-kamuicode.example.json を mcp-kamuicode.json にコピー
cp .claude/mcp-kamuicode.example.json .claude/mcp-kamuicode.json

# エディタで .claude/mcp-kamuicode.json を開いて、実際のAPIキーを入力
vi .claude/mcp-kamuicode.json
```

## ステップ 2: APIキーの取得

### FAL API キー（必須）
1. [FAL.ai](https://fal.ai/) にサインアップ
2. ダッシュボードからAPIキーを取得
3. `.env` と `.claude/mcp-kamuicode.json` の `FAL_KEY` に設定

## トラブルシューティング

### よくある問題

1. **APIキーエラー**
   - `.env` と `.claude/mcp-kamuicode.json` の両方にAPIキーが設定されているか確認
   - APIキーに余分なスペースや改行が含まれていないか確認

2. **MCPサーバーエラー**
   - Node.js がインストールされているか確認
   - `npx` コマンドが利用可能か確認

3. **ffmpegエラー**
   - ffmpeg がインストールされているか確認: `ffmpeg -version`


## 次のステップ

セットアップが完了したら、[workflow/presenter-video-generation/README.md](./workflow/presenter-video-generation/README.md) を参照してワークフローの使用方法を確認してください。