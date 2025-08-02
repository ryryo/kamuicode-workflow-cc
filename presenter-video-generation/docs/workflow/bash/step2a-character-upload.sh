#!/bin/bash

# ====== Step2a: Character Image Upload to FAL (for speaker-type=custom with local image) ======

# 入力パラメータ
CHARACTER_IMAGE="${1:-}"
FOLDER_NAME="${2:-}"
VIDEO_INDEX="${3:-1}"

# パラメータチェック
if [ -z "$CHARACTER_IMAGE" ]; then
  echo "❌ Error: CHARACTER_IMAGE is required"
  echo "Usage: $0 <character_image_path> <folder_name> [video_index]"
  exit 1
fi

if [ -z "$FOLDER_NAME" ]; then
  echo "❌ Error: FOLDER_NAME is required"
  echo "Usage: $0 <character_image_path> <folder_name> [video_index]"
  exit 1
fi

# ファイル存在確認
if [ ! -f "$CHARACTER_IMAGE" ]; then
  echo "❌ Error: Character image file not found: $CHARACTER_IMAGE"
  exit 1
fi

echo "====== Character Image Upload to FAL ======"
echo "Image file: $CHARACTER_IMAGE"
echo "Folder: $FOLDER_NAME"
echo "Video index: $VIDEO_INDEX"

# ディレクトリ設定
VIDEO_BASE_DIR="$FOLDER_NAME/video$VIDEO_INDEX"
IMAGES_DIR="$VIDEO_BASE_DIR/images"
UPLOAD_RESULT_FILE="$IMAGES_DIR/character-fal-url.txt"
VENV_DIR=".venv"

# ディレクトリ作成（必要に応じて）
mkdir -p "$IMAGES_DIR"

# .envファイルから環境変数を読み込み
if [ -f ".env" ]; then
  echo "📄 Loading environment variables from .env file..."
  export $(grep -v '^#' .env | xargs)
fi

# FAL_KEY環境変数チェック
if [ -z "$FAL_KEY" ]; then
  echo "❌ Error: FAL_KEY environment variable is not set"
  echo "Please check .env file or set: export FAL_KEY='your_fal_api_key'"
  exit 1
fi

# Python環境チェック
if ! command -v python3 >/dev/null 2>&1; then
  echo "❌ Error: python3 is not installed"
  exit 1
fi

# 仮想環境を作成・アクティベート
echo "🔧 Setting up Python virtual environment..."
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
fi

# 仮想環境をアクティベート
source "$VENV_DIR/bin/activate"

# fal-client インストール確認・インストール
echo "📦 Installing fal-client..."
pip install --quiet fal-client python-dotenv

# FALアップロード実行
echo "📤 Uploading character image to FAL using fal_client..."

# Pythonスクリプトで実行
python3 << EOF
import fal_client
import os
import sys

try:
    # FAL_KEY環境変数から認証
    fal_key = os.environ.get('FAL_KEY')
    if not fal_key:
        print("❌ Error: FAL_KEY not found in environment")
        sys.exit(1)
    
    # fal_clientを設定
    fal_client.api_key = fal_key
    
    # ファイルアップロード
    file_path = "$CHARACTER_IMAGE"
    print(f"Uploading: {file_path}")
    
    url = fal_client.upload_file(file_path)
    print(f"✅ Upload successful!")
    print(f"FAL URL: {url}")
    
    # URLをファイルに保存
    with open("$UPLOAD_RESULT_FILE", "w") as f:
        f.write(url)
    
    print(f"✅ URL saved to: $UPLOAD_RESULT_FILE")
    
except Exception as e:
    print(f"❌ Upload failed: {e}")
    sys.exit(1)
EOF

# 仮想環境を非アクティベート
deactivate

# アップロード結果確認
if [ $? -eq 0 ] && [ -f "$UPLOAD_RESULT_FILE" ]; then
  FAL_URL=$(cat "$UPLOAD_RESULT_FILE")
  echo "✅ Character image uploaded successfully"
  echo "FAL URL: $FAL_URL"
  echo "Result saved to: $UPLOAD_RESULT_FILE"
  
  # 成功時はFAL URLを標準出力
  echo "$FAL_URL"
else
  echo "❌ Character image upload failed"
  exit 1
fi