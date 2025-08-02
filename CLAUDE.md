# CLAUDE.md

このファイルは、このリポジトリでコードを扱う際のClaude Code (claude.ai/code)へのガイダンスを提供します。

## プロジェクト概要

このプロジェクトは、kamuicode Workflowsをベースにしたプレゼンター動画生成ワークフローの公開コンポーネント集です。主要なワークフローは、AIを活用してプレゼンター動画を自動生成することです。

## 主要なワークフロー実行

### プレゼンター動画生成ワークフロー

実行の際は以下の手順に従ってください：

1. **初期設定**: `presenter-video-generation-workflow.md:127` の手順に従い、`step0-setup.sh`を実行
2. **ワークフロー実行**: workflow.mdの6つのステップを順次実行
   - Step0: 初期設定（setup.sh）
   - Step1: コンテンツ企画（Claude Code実行）
   - Step2a: プレゼンター画像生成（Claude Code実行）
   - Step2b: 音声生成（Claude Code実行）
   - Step3: ベース動画生成（Claude Code実行）
   - Step4: リップシンク生成（Claude Code実行）
   - Step5: 字幕解析（Claude Code実行）
   - Step6: 字幕オーバーレイ（Claude Code実行）

#### 重要な実行要件

- **依存ツール**: ffmpeg、curl、Python 3.x が必須
- **API設定**: `.env` と `.claude/mcp-kamuicode.json` に設定されていること
- **プロンプトファイル読み込み**: 各ステップで必ずReadツールを使って対応するプロンプトファイルを読み込む
- **環境変数**: step0-setup.shで設定された環境変数を後続ステップで使用

#### 主要な設定パラメータ

- `topic`: プレゼンテーションのトピック（必須）
- `content`: コンテンツの具体的内容（必須）
- `speaker-type`: 話し手タイプ（news-anchor、youtuber、receptionist等）
- `video-duration`: 動画の長さ（秒、デフォルト60）
- `aspect-ratio`: 画面比率（9:16、16:9等）

## ファイル構造の理解

- `/workflow/presenter-video-generation/`: メインワークフロー
  - `presenter-video-generation-workflow.md`: 実行手順書
  - `/bash/`: シェルスクリプト群
  - `/prompts/presenter-video-generation/`: AIプロンプトテンプレート
- `/result/`: 生成された動画等の出力先

## 検証とバリデーション

- 音声生成後は `step2b-audio-validation.sh` で検証を実行
- 字幕解析後は `step5-subtitle-analysis-check.sh` で確認を実行
- ffmpegを使用した動画処理では処理ログを必ず保存
