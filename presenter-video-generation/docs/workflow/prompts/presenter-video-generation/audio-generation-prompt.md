# Audio Generation Prompt

指定されたモデルタイプを使用して音声を生成してください。

**元のユーザー指示**: {USER_CONCEPT}
**使用するモデルタイプ**: {MODEL_TYPE}
**テキストプロンプト**: {TEXT_PROMPT}
**音声設定**: {VOICE_SETTINGS}

**実行手順**:
1. まず、`module-workflow/kamuicode/kamuicode-usage.md`ファイルを読み込んで、モデルタイプ「{MODEL_TYPE}」に対応するMCPツール名を確認してください
2. ファイルから以下の情報を抽出:
   - submitツール名（例: mcp__t2s-fal-minimax-speech-02-turbo__minimax_speech_02_turbo_submit）
   - statusツール名（例: mcp__t2s-fal-minimax-speech-02-turbo__minimax_speech_02_turbo_status）
   - resultツール名（例: mcp__t2s-fal-minimax-speech-02-turbo__minimax_speech_02_turbo_result）
3. モデルタイプに応じて適切なパラメータを使用:
   - **t2s-で始まる場合**: テキストプロンプト（{TEXT_PROMPT}）と音声設定（{VOICE_SETTINGS}）を使用してテキストから音声生成
4. submitツールで音声生成を開始
5. statusツールでステータス確認（音声生成は比較的高速ですが、適度な間隔で確認）
6. 必要に応じてBashツールで `sleep 30` を実行してから再度ステータス確認
7. resultツールで結果取得して音声URLを取得
   - `output_directory`に「{AUDIO_DIR}」を指定
   - `filename_prefix`に「audio」を指定（自動的にaudio.mp3としてダウンロードされる）
8. **必須**: 取得した音声URLを「{AUDIO_DIR}/audio-url.txt」ファイルに保存
9. **必須**: 取得した音声URLをcurlコマンドで「{AUDIO_DIR}/audio.mp3」にダウンロード保存（例: curl -o "{AUDIO_DIR}/audio.mp3" "音声URL"）

10. **リップシンク制限対応チェック**
    - ffprobeで音声ファイルの時間と容量を確認
    - `NEWS_DURATION`が30秒以下の場合、Pixverse制限（30秒/5MB）をチェック
    - 制限チェック手順:
      ```bash
      # workflow-info.jsonからNEWS_DURATIONを取得
      NEWS_DURATION=$(cat {FOLDER_NAME}/workflow-info.json | grep "news_duration" | cut -d'"' -f4)
      
      DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "{AUDIO_DIR}/audio.mp3")
      SIZE_BYTES=$(ffprobe -v quiet -show_entries format=size -of csv=p=0 "{AUDIO_DIR}/audio.mp3")
      SIZE_MB=$(echo "scale=2; $SIZE_BYTES/1024/1024" | bc)
      
      echo "Audio: ${DURATION}s / ${SIZE_MB}MB, Target: ${NEWS_DURATION}s"
      
      # NEWS_DURATIONが30秒以下の場合のみPixverse制限チェック
      if [ "$NEWS_DURATION" -le 30 ]; then
        if (( $(echo "$DURATION > 30" | bc -l) )) || (( $(echo "$SIZE_MB > 5" | bc -l) )); then
          echo "⚠️ Pixverse制限超過、台本短縮が必要"
          # 台本短縮処理を実行
        else
          echo "✅ Pixverse制限内"
        fi
      else
        echo "✅ Creatify使用、制限なし"
      fi
      ```

11. **台本短縮プロンプト**（制限超過時のみ実行）
    - `NEWS_DURATION`に基づいて適切な長さに台本を短縮
    - 元の台本「{TEXT_PROMPT}」を指定時間以内（約{NEWS_DURATION}×5文字以内）に短縮
    - 重要な情報を保持しながら簡潔にまとめる
    - ニュースの核心部分のみを残す
    - 短縮版台本で手順4-9を再実行
    - 制限を満たすまで繰り返し

**重要な注意点**:
- kamuicode-usage.mdから正しいツール名を読み取ること
- 音声生成は比較的高速ですが、ステータス確認は適度な間隔で行うこと
- Google URLの有効期限は約1時間のため、生成後すぐにダウンロード
- 必ずGoogle提供の認証済URLを使用
- 音声は必ず「{AUDIO_DIR}」ディレクトリに保存
- ファイル名は「audio.mp3」または「audio.wav」とする
- **最重要**: 生成時の音声URLを「{AUDIO_DIR}/audio-url.txt」に保存し、次のジョブで参照できるようにする
- **両方を実行**: ①音声URLをテキストファイルに保存 ②音声URLから音声をダウンロードしてローカル保存
- **注意**: MCPツールのresultで表示される「Downloaded Files」はファイルパスの例示であり、実際のダウンロードはcurlコマンドで行う必要がある