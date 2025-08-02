# Lipsync Generation Prompt

指定されたモデルタイプを使用してリップシンク動画を生成してください。

**元のユーザー指示**: {USER_CONCEPT}
**使用するモデルタイプ**: {MODEL_TYPE}
**入力動画URL**: {VIDEO_URL}
**入力音声URL**: {AUDIO_URL}
**リップシンク設定**: {LIPSYNC_SETTINGS}

**実行手順**:
1. まず、`module-workflow/kamuicode/kamuicode-usage.md`ファイルを読み込んで、モデルタイプ「{MODEL_TYPE}」に対応するMCPツール名を確認してください
2. ファイルから以下の情報を抽出:
   - submitツール名（例: mcp__v2v-fal-creatify-lipsync__submit）
   - statusツール名（例: mcp__v2v-fal-creatify-lipsync__status）
   - resultツール名（例: mcp__v2v-fal-creatify-lipsync__result）
3. モデルタイプに応じて適切なパラメータを使用:
   - **v2v-で始まる場合**: 動画URL（{VIDEO_URL}）と音声URL（{AUDIO_URL}）を使用してリップシンク動画生成
4. submitツールでリップシンク生成を開始
5. statusツールでステータス確認（リップシンク生成は時間がかかるため、適度な間隔で確認）
6. 必要に応じてBashツールで `sleep 60` を実行してから再度ステータス確認
7. resultツールで結果取得してリップシンク動画URLを取得
8. **必須**: 取得したリップシンク動画URLを「{LIPSYNC_DIR}/lipsync-video-url.txt」ファイルに保存
9. **必須**: 取得したリップシンク動画URLをcurlコマンドで「{LIPSYNC_DIR}/lipsync-video.mp4」にダウンロード保存（例: curl -o "{LIPSYNC_DIR}/lipsync-video.mp4" "リップシンク動画URL"）

**重要な注意点**:
- kamuicode-usage.mdから正しいツール名を読み取ること
- リップシンク生成は時間がかかるため、ステータス確認の間に適度な待機時間を入れること
- Google URLの有効期限は約1時間のため、生成後すぐにダウンロード
- 必ずGoogle提供の認証済URLを使用（入力URLも出力URLも）
- 動画は必ず「{LIPSYNC_DIR}」ディレクトリに保存
- ファイル名は「lipsync-video.mp4」とする
- **最重要**: 生成時のリップシンク動画URLを「{LIPSYNC_DIR}/lipsync-video-url.txt」に保存し、次のジョブで参照できるようにする
- **両方を実行**: ①リップシンク動画URLをテキストファイルに保存 ②リップシンク動画URLから動画をダウンロードしてローカル保存
- **入力ファイルについて**: 動画URLと音声URLは既に認証済みのGoogleリンクを使用
- **注意**: MCPツールのresultで表示される「Downloaded Files」はファイルパスの例示であり、実際のダウンロードはcurlコマンドで行う必要がある