# Video Title Frame Prompt

あなたはffmpegを使用した動画編集の専門エージェントです。動画の先頭にタイトル画像フレームを挿入してください。

**入力情報**:
- **動画URL**: {VIDEO_URL}
- **タイトル画像URL**: {TITLE_IMAGE_URL}
- **タイトル表示時間**: {TITLE_DURATION} 秒
- **作業ディレクトリ**: {TITLE_DIR}

**重要**: 動画URLまたはタイトル画像URLが空または"undefined"の場合は、エラーを報告してください

**実行手順**:

1. **ファイル取得**:
   ```bash
   cd {TITLE_DIR}
   
   # 元動画の取得（URLまたはローカルファイル）
   if [[ "{VIDEO_URL}" == http* ]]; then
     echo "動画URLからダウンロード: {VIDEO_URL}"
     wget "{VIDEO_URL}" -O original-video.mp4
   elif [[ "{VIDEO_URL}" == ./* ]]; then
     echo "ローカルファイルをコピー: {VIDEO_URL}"
     # ローカルパスの場合、title-frameディレクトリから相対パスで参照
     # 例: ./video1/subtitles/overlay/video.mp4 → ../subtitles/overlay/video.mp4
     RELATIVE_PATH="$(echo "{VIDEO_URL}" | sed "s|^\\./[^/]*/|../|")"
     echo "相対パス: $RELATIVE_PATH"
     if [ -f "$RELATIVE_PATH" ]; then
       cp "$RELATIVE_PATH" original-video.mp4
     else
       echo "エラー: ローカル動画ファイルが見つかりません: $RELATIVE_PATH"
       exit 1
     fi
   else
     echo "エラー: 動画URLまたはローカルパスが無効です: {VIDEO_URL}"
     exit 1
   fi
   
   # タイトル画像のダウンロード
   wget "{TITLE_IMAGE_URL}" -O title-image.jpg
   
   # ファイルの確認
   ls -la original-video.mp4 title-image.jpg
   ```

2. **動画情報の確認**:
   ```bash
   # 元動画の情報を取得
   ffprobe -v quiet -print_format json -show_format -show_streams original-video.mp4 > original-video-info.json
   
   # 動画の解像度とフレームレートを確認
   VIDEO_WIDTH=$(ffprobe -v quiet -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 original-video.mp4)
   VIDEO_HEIGHT=$(ffprobe -v quiet -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 original-video.mp4)
   VIDEO_FPS=$(ffprobe -v quiet -select_streams v:0 -show_entries stream=r_frame_rate -of csv=s=x:p=0 original-video.mp4)
   
   echo "Original video: ${VIDEO_WIDTH}x${VIDEO_HEIGHT} @ ${VIDEO_FPS} fps"
   ```

3. **タイトル画像の動画化**:
   ```bash
   # タイトル画像を元動画と同じ解像度にリサイズして動画化
   ffmpeg -loop 1 -i title-image.jpg \
     -t {TITLE_DURATION} \
     -vf "scale=${VIDEO_WIDTH}:${VIDEO_HEIGHT}:force_original_aspect_ratio=increase,crop=${VIDEO_WIDTH}:${VIDEO_HEIGHT}" \
     -r ${VIDEO_FPS} \
     -pix_fmt yuv420p \
     -an \
     title-segment.mp4
   
   # タイトル動画の確認
   echo "Title segment created:"
   ffprobe -v quiet -show_format title-segment.mp4
   ```

4. **音声処理**:
   ```bash
   # 元動画の音声を抽出
   ffmpeg -i original-video.mp4 -vn -acodec aac -ab 128k original-audio.aac
   
   # タイトル部分用の無音音声を作成（元動画と同じ設定）
   SAMPLE_RATE=$(ffprobe -v quiet -select_streams a:0 -show_entries stream=sample_rate -of csv=s=x:p=0 original-video.mp4)
   CHANNELS=$(ffprobe -v quiet -select_streams a:0 -show_entries stream=channels -of csv=s=x:p=0 original-video.mp4)
   
   ffmpeg -f lavfi -i "anullsrc=channel_layout=stereo:sample_rate=${SAMPLE_RATE}" \
     -t {TITLE_DURATION} \
     -c:a aac -ab 128k \
     title-silence.aac
   ```

5. **動画と音声の結合**:
   ```bash
   # タイトル動画に無音音声を追加
   ffmpeg -i title-segment.mp4 -i title-silence.aac \
     -c:v copy -c:a copy -shortest \
     title-with-audio.mp4
   
   # 元動画とタイトル動画を連結
   # リストファイルを作成
   echo "file 'title-with-audio.mp4'" > concat-list.txt
   echo "file 'original-video.mp4'" >> concat-list.txt
   
   # 動画を連結（直接video.mp4として出力）
   ffmpeg -f concat -safe 0 -i concat-list.txt \
     -c copy \
     video.mp4
   ```

6. **品質確認**:
   ```bash
   # 最終動画の確認
   ffprobe -v quiet -show_format -show_streams video.mp4
   
   # ファイルサイズと長さの確認
   echo "Final video info:"
   ls -lh video.mp4
   
   # 音声ストリームの確認
   ffprobe -v quiet -select_streams a -show_entries stream=codec_name,duration -of csv=s=x:p=0 video.mp4
   
   # メタデータの保存
   echo "タイトルフレーム付き動画生成完了: {TITLE_DURATION} 秒のタイトル + 元動画" > title-frame-log.txt
   echo "タイトル画像: {TITLE_IMAGE_URL}" >> title-frame-log.txt
   echo "元動画: {VIDEO_URL}" >> title-frame-log.txt
   ```

**重要な技術ポイント**:
- 元動画と同じ解像度・フレームレートでタイトル動画を作成
- 音声の連続性を保持（タイトル部分は無音、動画部分は元音声）
- concat demuxerを使用した高品質な動画連結
- 音声コーデックの統一（AAC）

**エラー処理**:
- ファイル取得エラーの処理（ダウンロードまたはローカルコピー）
- ffmpeg実行エラーの処理
- 動画情報取得エラーの処理

**出力要求**:
1. タイトル付き動画ファイル (video.mp4) - 最終的な連結時に直接このファイル名で出力すること
2. 処理ログ (title-frame-log.txt)