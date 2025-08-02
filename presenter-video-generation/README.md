# Presenter Video Generation Workflow

AIを活用してプレゼンター動画を自動生成するワークフローシステムです。

## 🌟 特徴

- **7種類の話し手タイプ + カスタムキャラクター対応**
  - ニュースアナウンサー、YouTuber、受付、広報、営業、講師、CEO
  - カスタムキャラクター画像のi2i変換対応
- **多言語対応**: 日本語・英語
- **高品質な動画生成**
  - リップシンク動画生成
  - 字幕自動生成・オーバーレイ
  - 複数のアスペクト比対応（1:1, 9:16, 16:9, 3:4, 4:3）
- **柔軟なカスタマイズ**
  - プレゼンテーションスタイル選択（formal, casual, friendly, energetic）
  - 音声設定のカスタマイズ
  - 動画長さの調整（デフォルト60秒）

## 📦 ファイル構成

```
presenter-video-generation/
├── docs/
│   └── workflow/
│       ├── presenter-video-generation-workflow.md  # メインドキュメント
│       ├── prompts/                               # AIプロンプト集
│       │   └── presenter-video-generation/
│       │       ├── content-planning-prompt.md     # コンテンツ企画
│       │       ├── image-generation-prompt.md     # 画像生成
│       │       ├── audio-generation-prompt.md     # 音声生成
│       │       ├── video-generation-prompt.md     # 動画生成
│       │       ├── lipsync-generation-prompt.md   # リップシンク
│       │       ├── subtitle-analysis-prompt.md    # 字幕解析
│       │       └── subtitle-overlay-prompt.md     # 字幕オーバーレイ
│       └── bash/                                  # 実行スクリプト
│           ├── step0-setup.sh                     # 初期設定
│           ├── step2a-character-upload.sh         # キャラクターアップロード
│           ├── step2b-audio-validation.sh         # 音声検証
│           └── step5-subtitle-analysis-check.sh   # 字幕チェック
└── assets/
    └── sample-characters/                         # サンプルキャラクター画像
```

## 🚀 使用方法

### 基本的な実行例

```bash
# ニュースアナウンサーによるプレゼンテーション
TOPIC="新製品の紹介" CONTENT="最新のAI技術を搭載した革新的な製品について説明します。" ./docs/workflow/bash/step0-setup.sh

# YouTuber男性による商品紹介（エネルギッシュスタイル）
TOPIC="スマートウォッチレビュー" CONTENT="今回紹介するのは最新のスマートウォッチです。" SPEAKER_TYPE="youtuber" SPEAKER_GENDER="male" PRESENTATION_STYLE="energetic" ./docs/workflow/bash/step0-setup.sh
```

### カスタムキャラクターの使用

```bash
# URLから画像を使用
TOPIC="会社紹介" CONTENT="私たちの会社について紹介します。" SPEAKER_TYPE="custom" CHARACTER_IMAGE="https://example.com/character.png" CHARACTER_DESCRIPTION="青い髪のアニメ風キャラクター" ./docs/workflow/bash/step0-setup.sh

# ローカル画像を使用
TOPIC="製品デモ" CONTENT="新機能のデモンストレーションを行います。" SPEAKER_TYPE="custom" CHARACTER_IMAGE="./assets/my-character.png" ./docs/workflow/bash/step0-setup.sh
```

## 📋 パラメータ一覧

### 必須パラメータ
- `topic`: プレゼンテーションのトピック
- `content`: 具体的な内容・情報

### オプションパラメータ
- `target-language`: 言語（japanese/english、デフォルト: japanese）
- `speaker-type`: 話し手タイプ（デフォルト: news-anchor）
- `speaker-gender`: 性別（female/male、デフォルト: female）
- `presentation-style`: スタイル（formal/casual/friendly/energetic、デフォルト: formal）
- `aspect-ratio`: 画面比率（デフォルト: 9:16）
- `video-duration`: 動画の長さ（秒、デフォルト: 60）
- `character-image`: カスタムキャラクター画像（speaker-type=custom時）
- `character-description`: キャラクター説明（speaker-type=custom時、オプション）

## 🛠️ 必要な環境

- Claude Code SDK
- kamuicode MCP
- ffmpeg（動画・音声処理）
- curl（ファイルダウンロード）
- Python 3.x（FALアップロード時）

## 📝 詳細ドキュメント

詳細な実装手順やワークフローの仕組みについては、[presenter-video-generation-workflow.md](./docs/workflow/presenter-video-generation-workflow.md) を参照してください。

## 🤝 クレジット

このワークフローは [kamuicode Workflows](https://github.com/khomma/kamuicode-workflow) プロジェクトをベースに開発されました。

## 📄 ライセンス

MITライセンス（詳細は上位ディレクトリのLICENSEファイルを参照）