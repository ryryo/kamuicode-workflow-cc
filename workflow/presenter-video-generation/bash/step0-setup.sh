#!/bin/bash

# ====== Presenter Video Generation Workflow - Step0: 初期設定・下準備 ======
# 重要: このスクリプトを1つのBashセッションで実行してください（環境変数の引き継ぎのため）

# ====== 入力パラメータ設定 ======
# 必須パラメータ
TOPIC="${TOPIC:-}"
CONTENT="${CONTENT:-}"

# 必須パラメータのチェック
if [ -z "$TOPIC" ]; then
  echo "❌ Error: TOPIC is required"
  echo "Usage: TOPIC=\"your topic\" CONTENT=\"your content\" $0"
  exit 1
fi

if [ -z "$CONTENT" ]; then
  echo "❌ Error: CONTENT is required"  
  echo "Usage: TOPIC=\"your topic\" CONTENT=\"your content\" $0"
  exit 1
fi

# 任意パラメータ（デフォルト値使用）
TARGET_LANGUAGE="${TARGET_LANGUAGE:-japanese}"
VIDEO_INDEX="${VIDEO_INDEX:-1}"
VIDEO_DURATION="${VIDEO_DURATION:-60}"
SPEAKER_TYPE="${SPEAKER_TYPE:-news-anchor}"
SPEAKER_GENDER="${SPEAKER_GENDER:-female}"
PRESENTATION_STYLE="${PRESENTATION_STYLE:-formal}"
TEXT_PROMPT="${TEXT_PROMPT:-}"
ASPECT_RATIO="${ASPECT_RATIO:-9:16}"
CHARACTER_IMAGE="${CHARACTER_IMAGE:-}"
CHARACTER_DESCRIPTION="${CHARACTER_DESCRIPTION:-}"

# speaker-type=custom の場合の検証
if [ "$SPEAKER_TYPE" = "custom" ]; then
  if [ -z "$CHARACTER_IMAGE" ]; then
    echo "❌ Error: CHARACTER_IMAGE is required when SPEAKER_TYPE is 'custom'"
    echo "Usage: SPEAKER_TYPE=\"custom\" CHARACTER_IMAGE=\"path/or/url\" $0"
    exit 1
  fi
  
  # CHARACTER_IMAGE がURLかローカルパスかを判定
  if [[ "$CHARACTER_IMAGE" =~ ^https?:// ]]; then
    CHARACTER_IMAGE_TYPE="url"
    echo "✅ Character image type: URL ($CHARACTER_IMAGE)"
  else
    CHARACTER_IMAGE_TYPE="local"
    # ローカルファイルの存在確認
    if [ ! -f "$CHARACTER_IMAGE" ]; then
      echo "❌ Error: Character image file not found: $CHARACTER_IMAGE"
      exit 1
    fi
    echo "✅ Character image type: Local file ($CHARACTER_IMAGE)"
  fi
fi

echo "====== Step0: ワークフロー初期化開始 ======"

# ====== 1. タイムスタンプとベースフォルダ設定 ======
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
echo "Workflow started at: $TIMESTAMP"

# フォルダ名設定
if [ -z "${FOLDER_NAME:-}" ]; then
  FOLDER_NAME="result/presenter/$TIMESTAMP"
  echo "Using default folder: $FOLDER_NAME"
else
  echo "Using specified folder: $FOLDER_NAME"
fi

# 環境変数として設定
export FOLDER_NAME
export WORKFLOW_TIMESTAMP="$TIMESTAMP"
export TOPIC
export CONTENT
export TARGET_LANGUAGE
export VIDEO_INDEX
export VIDEO_DURATION
export SPEAKER_TYPE
export SPEAKER_GENDER
export PRESENTATION_STYLE
export TEXT_PROMPT
export ASPECT_RATIO
export CHARACTER_IMAGE
export CHARACTER_DESCRIPTION
export CHARACTER_IMAGE_TYPE

# ====== 2. ディレクトリ構造作成 ======
echo "Creating directory structure..."
mkdir -p "$FOLDER_NAME"/video$VIDEO_INDEX/{planning,images,audio,videos,lipsync,subtitles/{analysis,overlay}}

echo "Created directory structure:"
tree "$FOLDER_NAME" 2>/dev/null || find "$FOLDER_NAME" -type d | sort

# ====== 3. システム要件確認 ======
echo "Checking system requirements..."

# ffmpeg確認  
if command -v ffmpeg >/dev/null 2>&1; then
  echo "✅ ffmpeg is installed: $(ffmpeg -version | head -1)"
else
  echo "❌ ffmpeg is not installed. Please install ffmpeg first."
  exit 1
fi

# curl確認
if command -v curl >/dev/null 2>&1; then
  echo "✅ curl is available"
else
  echo "❌ curl is not available. Please install curl."
  exit 1
fi

# ====== 4. ワークフロー情報保存 ======
cat > "$FOLDER_NAME/workflow-info.json" << EOF
{
  "workflow_type": "presenter-video-generation",
  "started_at": "$TIMESTAMP",
  "folder_name": "$FOLDER_NAME",
  "topic": "$TOPIC",
  "content": "$CONTENT",
  "target_language": "$TARGET_LANGUAGE",
  "video_duration": "$VIDEO_DURATION",
  "speaker_type": "$SPEAKER_TYPE",
  "speaker_gender": "$SPEAKER_GENDER",
  "presentation_style": "$PRESENTATION_STYLE",
  "text_prompt": "$TEXT_PROMPT",
  "aspect_ratio": "$ASPECT_RATIO",
  "character_image": "$CHARACTER_IMAGE",
  "character_description": "$CHARACTER_DESCRIPTION",
  "character_image_type": "${CHARACTER_IMAGE_TYPE:-}"
}
EOF

echo "✅ Workflow preparation completed"
echo "Base folder: $FOLDER_NAME"
echo "Timestamp: $TIMESTAMP"
echo "All environment variables exported for subsequent steps"
echo "==========================================="