# Subtitle Overlay Prompt

あなたはffmpegを使用した動画字幕オーバーレイの専門エージェントです。リップシンク動画に字幕を挿入してください。

**入力情報**:
- **動画URL**: {VIDEO_URL}
- **SRT字幕データ**: 受け取ったSRT形式の字幕内容
- **字幕言語**: {TARGET_LANGUAGE}
- **出力ディレクトリ**: {SUBTITLE_DIR}

**重要**: 動画URLが空または"undefined"の場合は、エラーを報告してください

**実行手順**:

1. **既存ファイルの参照**:
   - SRT字幕ファイル: `{ANALYSIS_DIR}/subtitle.srt` (Step5で作成済み)
   - 入力動画ファイル: `{LIPSYNC_DIR}/lipsync-video.mp4` (Step4で作成済み)

2. **作業ディレクトリ移動**:
   ```bash
   cd {SUBTITLE_DIR}
   ```

3. **フォント設定**:
   - 日本語の場合: /usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc または利用可能なCJKフォント
   - 英語の場合: /usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf
   ```bash
   # 利用可能なフォントを確認
   fc-list | grep -i "{TARGET_LANGUAGE} == 'japanese' && 'noto\\|cjk' || 'liberation\\|arial'"
   ```

4. **ffmpeg字幕オーバーレイ実行**:
   srtファイルを参照してffmpegで字幕を埋め込み:
   ```bash
   # 字幕オーバーレイ
   # FontSize=24: 適切な可読性を確保（大きすぎない）
   # MarginV=50: 画面下から50ピクセル上に配置
   # Alignment=2: 下部中央配置
   # PrimaryColour=&Hffffff: 白文字
   # BackColour=&H80000000: 半透明黒背景
   # Outline=2,OutlineColour=&H000000: 黒い縁取り2px
   ffmpeg -i {LIPSYNC_DIR}/lipsync-video.mp4 \
     -vf "subtitles={ANALYSIS_DIR}/subtitle.srt:force_style='FontSize=24,PrimaryColour=&Hffffff,BackColour=&H80000000,Outline=2,OutlineColour=&H000000,Alignment=2,MarginV=50'" \
     -c:a copy \
     video.mp4
   ```

5. **品質確認**:
   ```bash
   # 出力動画の確認
   ffprobe video.mp4
   
   # ファイルサイズと長さの確認
   ls -lh video.mp4
   
   # メタデータの保存
   echo "SRT字幕付き動画生成完了" > subtitle-overlay-log.txt
   ```

**重要な技術ポイント**:
- SRTファイルを直接ffmpegのsubtitlesフィルターで処理
- 日本語フォントが正しく読み込まれることを確認
- **字幕サイズ**: FontSize=24で適切な可読性を確保（大きすぎない）
- **字幕位置**: 画面下部中央、下から50ピクセル上に配置（Alignment=2, MarginV=50）
- **視認性向上**: 白文字、半透明黒背景、黒い縁取り2pxで視認性を最大化
- 音声ストリームはそのまま保持 (-c:a copy)
- **標準的なSRT処理**: ffmpegの標準字幕処理機能を活用

**エラー処理**:
- 動画ダウンロードエラーの処理
- SRTファイル形式エラーの処理
- フォント読み込みエラーの処理
- ffmpeg実行エラーの処理

**出力要求**:
1. 字幕付き動画ファイル (video.mp4) - 直接このファイル名で出力すること
2. 処理ログ (subtitle-overlay-log.txt)