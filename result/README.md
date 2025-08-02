# 実行結果フォルダ

このフォルダには、ワークフロー実行時に生成されるファイルが保存されます。

## 生成されるファイル構造例

```
result/
└── presenter/
    └── {TIMESTAMP}/
        └── video{VIDEO_INDEX}/
            ├── planning/          # コンテンツ企画ファイル
            ├── images/           # 生成された画像
            ├── audio/            # 生成された音声
            ├── videos/           # ベース動画
            ├── lipsync/          # リップシンク動画
            └── subtitles/        # 字幕ファイル
                ├── analysis/     # 字幕解析結果
                └── overlay/      # 字幕オーバーレイ結果
```

## 注意事項

- このフォルダの中身はGitで管理されません（.gitignoreで除外）
- ワークフロー実行時に自動的にファイルが作成されます
- 生成されたファイルには、動画、音声、画像など大容量のファイルが含まれます

## 使用例

プレゼンター動画生成ワークフローを実行すると、以下のような構造でファイルが生成されます：

```
result/presenter/20250801-143755/video1/
├── planning/
│   ├── audio-prompt.txt
│   ├── image-prompt.txt
│   └── content-plan.md
├── images/
│   └── presenter.png
├── audio/
│   └── narration.mp3
├── videos/
│   └── base-video.mp4
├── lipsync/
│   └── lipsync-video.mp4
└── subtitles/
    ├── analysis/
    │   └── subtitle.srt
    └── overlay/
        └── final-video.mp4
```