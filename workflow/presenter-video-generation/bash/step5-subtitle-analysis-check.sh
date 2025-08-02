#!/bin/bash

# ====== News Video Generation Workflow - Step5: 字幕解析チェック ======

# パラメータの受け取り
FOLDER_NAME="$1"
VIDEO_INDEX="${2:-1}"

# 必要なパラメータのチェック
if [ -z "$FOLDER_NAME" ]; then
  echo "❌ Error: Required parameters not provided"
  echo "Usage: $0 <FOLDER_NAME> [VIDEO_INDEX]"
  echo "Example: $0 'result/news/20250730-120000' 1"
  exit 1
fi

echo "====== Step5: 字幕解析チェック ======"

VIDEO_BASE_DIR="$FOLDER_NAME/video$VIDEO_INDEX"
ANALYSIS_DIR="$VIDEO_BASE_DIR/subtitles/analysis"

# 音声メタデータ取得の部分
AUDIO_DIR="$VIDEO_BASE_DIR/audio"
AUDIO_FILE="$AUDIO_DIR/audio.mp3"

echo "Using analysis directory: $ANALYSIS_DIR"

# 音声ファイルからメタデータを取得
if [ -f "$AUDIO_FILE" ]; then
  DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$AUDIO_FILE")
  
  # 音声時間の表示
  echo "Audio duration: $DURATION seconds"
  
  # メタデータをファイルに保存
  cat > "$ANALYSIS_DIR/audio-metadata.json" << EOF
{
  "duration": $DURATION,
  "source_file": "$AUDIO_FILE",
  "analyzed_at": "$(date -Iseconds)"
}
EOF
  
  echo "✅ 音声メタデータを保存: $ANALYSIS_DIR/audio-metadata.json"
else
  echo "❌ Audio file not found: $AUDIO_FILE"
  echo "Step2bの音声生成を先に実行してください"
  exit 1
fi

# 生成されたファイルの確認
if [ -f "$ANALYSIS_DIR/subtitle.srt" ]; then
  echo "=== Generated SRT Content ==="
  cat "$ANALYSIS_DIR/subtitle.srt"
  
  # セグメント数の表示
  SEGMENT_COUNT=$(grep -c "^[0-9]" "$ANALYSIS_DIR/subtitle.srt" 2>/dev/null || echo "0")
  echo "✅ Generated $SEGMENT_COUNT subtitle segments"
  
  # SRTファイルの妥当性チェック
  if [ "$SEGMENT_COUNT" -gt 0 ]; then
    echo "✅ SRT字幕ファイルが正常に生成されました"
    
    # 字幕解析完了のマーカーファイル作成
    echo "subtitle_analysis_completed_at=$(date -Iseconds)" > "$ANALYSIS_DIR/.analysis_complete"
  else
    echo "⚠️ SRTファイルは存在しますが、字幕セグメントが見つかりません"
    exit 1
  fi
else
  echo "❌ SRT字幕ファイルが見つかりません: $ANALYSIS_DIR/subtitle.srt"
  echo "Claude Codeによる字幕解析処理を先に実行してください"
  exit 1
fi

# 分析レポートの確認
if [ -f "$ANALYSIS_DIR/analysis-report.md" ]; then
  echo "✅ 分析レポートが生成されています: $ANALYSIS_DIR/analysis-report.md"
else
  echo "⚠️ 分析レポートが見つかりません（オプション）"
fi

echo "✅ Step5 字幕解析チェック完了"