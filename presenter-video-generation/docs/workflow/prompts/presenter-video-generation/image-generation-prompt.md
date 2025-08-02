# Image Generation Prompt

指定されたモデルタイプとspeaker-typeに応じて高品質な画像を生成してください。

- **元のユーザー指示**: {USER_CONCEPT}
- **最適化された画像生成プロンプト**: {PLANNED_IMAGE_PROMPT}
- **使用するモデルタイプ**: {MODEL_TYPE}
- **話し手タイプ**: {SPEAKER_TYPE}
- **キャラクター画像** (SPEAKER_TYPEがcustomの場合): {CHARACTER_IMAGE}
- **キャラクター画像タイプ** (SPEAKER_TYPEがcustomの場合): {CHARACTER_IMAGE_TYPE}

**実行手順**:

## A. 通常のspeaker-type (news-anchor, youtuber等) の場合:

1. まず、`module-workflow/kamuicode/kamuicode-usage.md`ファイルを読み込んで、モデルタイプ「{MODEL_TYPE}」（通常はt2i-fal-imagen4-ultra）に対応するMCPツール名を確認してください
2. ファイルから以下の情報を抽出:
   - モデルの表示名（例: Imagen4 Ultra）
   - submitツール名（例: mcp__t2i-fal-imagen4-ultra__imagen4_ultra_submit）
   - statusツール名（例: mcp__t2i-fal-imagen4-ultra__imagen4_ultra_status）
   - resultツール名（例: mcp__t2i-fal-imagen4-ultra__imagen4_ultra_result）
3. **最適化された画像生成プロンプト**（{PLANNED_IMAGE_PROMPT}）を使用して、抽出したツールで画像生成
4. submitツールで画像生成を開始
5. statusツールでステータス確認
6. resultツールで結果取得してGoogle URLを取得
7. **重要**: 生成時に取得したGoogle URLを「{IMAGES_DIR}/image-url.txt」ファイルに保存
8. 取得したGoogle URLをcurlまたはwgetを使用して「{IMAGES_DIR}/image.png」にダウンロード保存

## B. speaker-type=custom の場合:

1. **キャラクター画像の準備**:
   - CHARACTER_IMAGE_TYPE=url の場合: {CHARACTER_IMAGE} をそのまま使用
   - CHARACTER_IMAGE_TYPE=local の場合: 
     - step2a-character-upload.sh スクリプトを実行してFALにアップロード
     - 実行コマンド: `./docs/workflow/bash/step2a-character-upload.sh "{CHARACTER_IMAGE}" "{FOLDER_NAME}" "{VIDEO_INDEX}"`
     - スクリプトは自動的にPython仮想環境（プロジェクトルート/.venv）を作成し、fal-clientをインストール
     - fal_client.upload_file()を使用してアップロード実行
     - アップロードされたFAL URLを{IMAGES_DIR}/character-fal-url.txtに保存
     - 保存されたURLを取得して使用

2. `module-workflow/kamuicode/kamuicode-usage.md`ファイルを読み込んで、「i2i-fal-flux-kontext-max」に対応するMCPツール名を確認
3. ファイルから以下の情報を抽出:
   - submitツール名（例: mcp__i2i-fal-flux-kontext-max__flux_kontext_submit）
   - statusツール名（例: mcp__i2i-fal-flux-kontext-max__flux_kontext_status）
   - resultツール名（例: mcp__i2i-fal-flux-kontext-max__flux_kontext_result）
4. submitツールで画像変換を開始:
   - image_url: キャラクター画像のURL（準備したURL）
   - prompt: i2iプロンプト（{PLANNED_IMAGE_PROMPT}）※Step1で生成されたi2i-prompt.txtの内容
   - resolution_mode: {ASPECT_RATIO} ※9:16等のアスペクト比を指定
5. statusツールでステータス確認
6. resultツールで結果取得して変換後の画像URLを取得
7. **重要**: 生成時に取得したURLを「{IMAGES_DIR}/image-url.txt」ファイルに保存
8. 取得したURLをcurlまたはwgetを使用して「{IMAGES_DIR}/image.png」にダウンロード保存

**重要な注意点**:
- kamuicode-usage.mdから正しいツール名を読み取ること
- Google URLの有効期限は約1時間のため、生成後すぐにダウンロード
- 必ずGoogle提供の認証済URLを使用
- 画像は必ず「{IMAGES_DIR}」ディレクトリに保存
- ファイル名は「image.png」とする
- **最重要**: 生成時のGoogle URLを「{IMAGES_DIR}/image-url.txt」に保存し、次のジョブで参照できるようにする
- **両方を実行**: ①Google URLをテキストファイルに保存 ②Google URLから画像をダウンロードしてローカル保存
- **注意**: MCPツールのresultで表示される「Downloaded Files」はファイルパスの例示であり、実際のダウンロードはcurlコマンドで行う必要がある