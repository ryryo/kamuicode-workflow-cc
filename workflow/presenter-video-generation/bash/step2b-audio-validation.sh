#!/bin/bash

# ====== News Video Generation Workflow - Step2b: 音声ファイル検証とリップシンク制限対応 ======

# パラメータの受け取り
FOLDER_NAME="$1"
VIDEO_INDEX="${2:-1}"
NEWS_DURATION="${3:-30}"

# 必要なパラメータのチェック
if [ -z "$FOLDER_NAME" ]; then
  echo "❌ Error: Required parameters not provided"
  echo "Usage: $0 <FOLDER_NAME> [VIDEO_INDEX] [NEWS_DURATION]"
  echo "Example: $0 'result/news/20250730-120000' 1 30"
  exit 1
fi

echo "====== Step2b: 音声ファイル検証とリップシンク制限対応 ======"

VIDEO_BASE_DIR="$FOLDER_NAME/video$VIDEO_INDEX"
AUDIO_DIR="$VIDEO_BASE_DIR/audio"

# 音声ファイルの時間と容量を確認
if [ -f "$AUDIO_DIR/audio.mp3" ]; then
  DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$AUDIO_DIR/audio.mp3")
  SIZE_BYTES=$(ffprobe -v quiet -show_entries format=size -of csv=p=0 "$AUDIO_DIR/audio.mp3")
  SIZE_MB=$(echo "scale=2; $SIZE_BYTES/1024/1024" | bc)
  
  echo "Audio duration: ${DURATION}s"
  echo "Audio size: ${SIZE_MB}MB"
  echo "Target news duration: ${NEWS_DURATION}s"
  
  # Step4でPixverseリップシンクを使用する場合の制限チェック
  # NEWS_DURATIONが30秒以下でPixverseを使う場合は5MB/30秒制限への対応が必須
  if [ "$NEWS_DURATION" -le 30 ]; then
    echo "📋 Pixverse制限チェック（NEWS_DURATION=${NEWS_DURATION}s ≤ 30s）"
    
    if (( $(echo "$DURATION > 30" | bc -l) )) || (( $(echo "$SIZE_MB > 5" | bc -l) )); then
      echo "⚠️ Pixverse制限超過: ${DURATION}s / ${SIZE_MB}MB > 30s / 5MB"
      echo "台本を短縮して音声を再生成する必要があります..."
      
      # 台本を30秒以内に短縮（約150文字以内）
      ORIGINAL_SCRIPT=$(cat "$VIDEO_BASE_DIR/planning/audio-prompt.txt")
      echo "元の台本: $ORIGINAL_SCRIPT"
      
      echo "❌ 制限超過のため、Claude Codeによる台本短縮と音声再生成が必要です"
      echo "   - 台本を150文字以内に短縮"
      echo "   - 短縮版で音声を再生成"
      echo "   - 再度制限チェック実行"
      exit 1
    else
      echo "✅ Pixverse制限内: ${DURATION}s / ${SIZE_MB}MB <= 30s / 5MB"
    fi
  else
    echo "📋 Creatify制限チェック（NEWS_DURATION=${NEWS_DURATION}s > 30s）"
    echo "✅ Creatify使用: 制限なし"
  fi
  
  # 音声メタデータを保存
  cat > "$AUDIO_DIR/audio-metadata.json" << EOF
{
  "duration": $DURATION,
  "size_mb": $SIZE_MB,
  "size_bytes": $SIZE_BYTES,
  "validation_passed": true,
  "lipsync_model": $([ "$NEWS_DURATION" -le 30 ] && echo "\"pixverse\"" || echo "\"creatify\""),
  "checked_at": "$(date -Iseconds)"
}
EOF

  echo "✅ 音声ファイル検証完了"
  echo "   - 音声時間: ${DURATION}s"
  echo "   - ファイルサイズ: ${SIZE_MB}MB"
  echo "   - 推奨リップシンクモデル: $([ "$NEWS_DURATION" -le 30 ] && echo "Pixverse" || echo "Creatify")"
  
else
  echo "❌ 音声ファイルが見つかりません: $AUDIO_DIR/audio.mp3"
  echo "Step2bの音声生成を先に実行してください"
  exit 1
fi