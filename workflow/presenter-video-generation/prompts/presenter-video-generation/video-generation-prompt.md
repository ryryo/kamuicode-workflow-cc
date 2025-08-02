# Video Generation Prompt

指定されたモデルタイプを使用して動画を生成してください。

**元のユーザー指示**: {USER_CONCEPT}
**使用するモデルタイプ**: {MODEL_TYPE}
**テキストプロンプト**: {TEXT_PROMPT}
**動画プロンプト**: {VIDEO_PROMPT}
**画像URL**: {IMAGE_URL}

**実行手順**:
1. まず、`module-workflow/kamuicode/kamuicode-usage.md`ファイルを読み込んで、モデルタイプ「{MODEL_TYPE}」に対応するMCPツール名を確認してください
2. ファイルから以下の情報を抽出:
   - submitツール名（例: mcp__i2v-fal-hailuo-02-pro__hailuo_02_submit）
   - statusツール名（例: mcp__i2v-fal-hailuo-02-pro__hailuo_02_status）
   - resultツール名（例: mcp__i2v-fal-hailuo-02-pro__hailuo_02_result）
3. モデルタイプに応じて適切なパラメータを使用:
   - **t2v-で始まる場合**: テキストプロンプト（{TEXT_PROMPT}）を使用してテキストから動画生成
   - **i2v-で始まる場合**: 画像URL（{IMAGE_URL}）と動画プロンプト（{VIDEO_PROMPT}）を使用して画像から動画生成
   - **r2v-で始まる場合**: 画像URL（{IMAGE_URL}）と動画プロンプト（{VIDEO_PROMPT}）を使用して参照動画生成
4. submitツールで動画生成を開始
5. statusツールでステータス確認（動画生成は時間がかかるため、適度な間隔で確認）
6. 必要に応じてBashツールで `sleep 60` を実行してから再度ステータス確認
7. resultツールで結果取得して動画URLを取得
8. **必須**: 取得した動画URLを「{VIDEOS_DIR}/video-url.txt」ファイルに保存
9. **必須**: 取得した動画URLをcurlコマンドで「{VIDEOS_DIR}/video.mp4」にダウンロード保存（例: curl -o "{VIDEOS_DIR}/video.mp4" "動画URL"）

**重要な注意点**:
- kamuicode-usage.mdから正しいツール名を読み取ること
- 動画生成は時間がかかるため、ステータス確認の間に適度な待機時間を入れること
- Google URLの有効期限は約1時間のため、生成後すぐにダウンロード
- 必ずGoogle提供の認証済URLを使用
- 動画は必ず「{VIDEOS_DIR}」ディレクトリに保存
- ファイル名は「video.mp4」とする
- **最重要**: 生成時の動画URLを「{VIDEOS_DIR}/video-url.txt」に保存し、次のジョブで参照できるようにする
- **両方を実行**: ①動画URLをテキストファイルに保存 ②動画URLから動画をダウンロードしてローカル保存
- **注意**: MCPツールのresultで表示される「Downloaded Files」はファイルパスの例示であり、実際のダウンロードはcurlコマンドで行う必要がある