# Banner Text Overlay Prompt

以下の指定テキストを一字一句変更せずにベース画像に合成してください。

**重要 - 利用可能ツール**:
- mcp__i2i-fal-flux-kontext-max__flux_kontext_submit
- mcp__i2i-fal-flux-kontext-max__flux_kontext_status
- mcp__i2i-fal-flux-kontext-max__flux_kontext_result

**絶対に変更禁止のテキスト**: '{USER_TEXT_CONTENT}'
**ベース画像URL**: {BASE_IMAGE_URL}
**バナーコンセプト**: {USER_CONCEPT}
**テキストレイアウト戦略**: {TEXT_LAYOUT_STRATEGY}

**最重要制約**:
- テキスト内容「{USER_TEXT_CONTENT}」は絶対に変更禁止
- スペル修正・翻訳・意訳・文字追加・削除は一切禁止
- 文字の大文字小文字変換も禁止
- 句読点・記号の変更も禁止
- レイアウト・フォント・色・サイズ・位置のみ調整可能

**実行手順**:
1. mcp__i2i-fal-flux-kontext-max__flux_kontext_submit ツールでテキスト合成を開始
   - input_image_url: {BASE_IMAGE_URL}
   - prompt: 「テキスト '{USER_TEXT_CONTENT}' を画像に合成してください。テキスト内容は一切変更せず、レイアウトとデザインのみ最適化してください。{TEXT_LAYOUT_STRATEGY}」
2. mcp__i2i-fal-flux-kontext-max__flux_kontext_status でステータス確認
3. mcp__i2i-fal-flux-kontext-max__flux_kontext_result で結果取得してGoogle URLを取得
4. **重要**: 生成時に取得したGoogle URLを「{BANNERS_DIR}/image-url.txt」ファイルに保存
5. 取得したGoogle URLをBashツールで「{BANNERS_DIR}/image.png」にダウンロード保存

**テキスト合成の詳細指示**:
- テキスト「{USER_TEXT_CONTENT}」の内容は絶対に変更しない
- {TEXT_LAYOUT_STRATEGY} に基づいて配置・スタイルを決定
- 読みやすさを最大化するフォント選択
- 背景との対比を考慮した色選択
- バナー広告として効果的な視覚インパクト

**品質要件**:
- 商用利用可能な高品質バナー
- テキストの視認性確保
- ブランドイメージとの調和
- 指定されたバナーサイズに最適化

**重要な注意点**:
- Google URLの有効期限は約1時間のため、生成後すぐにダウンロード
- 必ずGoogle提供の認証済URLを使用
- バナー画像は必ず「{BANNERS_DIR}」ディレクトリに保存
- ファイル名は「image.png」とする
- **最重要**: 生成時のGoogle URLを「{BANNERS_DIR}/image-url.txt」に保存し、次のジョブで参照できるようにする
- **両方を実行**: ①Google URLをテキストファイルに保存 ②Google URLから画像をダウンロードしてローカル保存