# Content Planning Prompt

あなたはプロのコンテンツ制作ディレクターです。以下の情報を基にプレゼンター動画の企画を作成してください。

## 話し手タイプ別設定ガイド

### news-anchor (ニュースアナウンサー)
- **服装**: フォーマルなスーツ、ブラウス
- **背景**: ニューススタジオ
- **口調**: 丁寧語、正確な発音
- **表情**: 真剣、信頼できる

### receptionist (受付・秘書)
- **服装**: オフィスカジュアル、制服
- **背景**: 受付カウンター、オフィス
- **口調**: 丁寧で親しみやすい
- **表情**: 笑顔、歓迎的

### pr-representative (広報担当)
- **服装**: スマートカジュアル
- **背景**: 商品展示、店舗
- **口調**: 熱意がある、説得的
- **表情**: エネルギッシュ、親しみやすい

### sales-person (営業担当)
- **服装**: ビジネススーツ
- **背景**: 会議室、企業ロゴ
- **口調**: 説得力がある、自信に満ちた
- **表情**: 堂々とした、プロフェッショナル

### youtuber (YouTuber・インフルエンサー)
- **服装**: トレンディなカジュアル
- **背景**: 個性的な部屋、カラフル
- **口調**: フランク、親近感がある
- **表情**: 明るい、表情豊か

### instructor (講師・インストラクター)
- **服装**: スマートカジュアル、教師らしい
- **背景**: 教室、ホワイトボード
- **口調**: 分かりやすい、教育的
- **表情**: 知的、親切

### ceo (経営者・役員)
- **服装**: 高級スーツ、エグゼクティブ
- **背景**: 高級オフィス、シティビュー
- **口調**: 権威的、ビジョナリー
- **表情**: 自信に満ちた、威厳ある

### custom (カスタムキャラクター)
- **服装**: キャラクター固有の服装を維持
- **背景**: シンプルでプロフェッショナル
- **口調**: プレゼンテーションスタイルに応じる
- **表情**: キャラクターの個性を保ちつつプレゼンター向けに調整

**トピック**: {TOPIC}
**コンテンツ内容**: {CONTENT}
**カスタムテキストプロンプト**: {CUSTOM_TEXT_PROMPT}
**翻訳先言語**: {TARGET_LANGUAGE}
**プレゼンテーションスタイル**: {PRESENTATION_STYLE}
**動画の長さ**: {VIDEO_DURATION} 秒
**話し手タイプ**: {SPEAKER_TYPE}
**話し手の性別**: {SPEAKER_GENDER}
**キャラクター説明**: {CHARACTER_DESCRIPTION}

**作成するもの**:

1. **音声プロンプト（プレゼンテーション原稿）** ({PLANNING_DIR}/audio-prompt.txt)
   - **重要な条件分岐**:
     * カスタムテキストプロンプトが指定されている場合（"{CUSTOM_TEXT_PROMPT}" が空でない場合）:
       → カスタムテキストプロンプトをそのまま使用
     * カスタムテキストプロンプトが空の場合:
       → ユーザー指定のコンテンツ内容「{CONTENT}」を基に、{VIDEO_DURATION} 秒の音声に適した長さのプレゼンテーション原稿を作成
   - **時間調整の指針**:
     * 日本語音声は1分間に約300-350文字が目安
     * {VIDEO_DURATION} 秒 = 約 {VIDEO_DURATION}×5-6文字 の原稿が必要
     * 元のコンテンツ内容を核として、話し手タイプ({SPEAKER_TYPE})に応じた口調やスタイルで構成
     * プレゼンテーションスタイル({PRESENTATION_STYLE})に合わせた適切な表現を使用
   - 選択された内容をファイルに保存
   - ファイルには改行を含めず、1行のテキストとして保存
   - 翻訳が必要な場合は自然で流暢な翻訳を心がける
   - 元のコンテンツ内容の事実を正確に保持しながら、話し手タイプに適した表現で膨らませること

2. **画像プロンプト** ({PLANNING_DIR}/image-prompt.txt) - **speaker-type=custom以外の場合のみ作成**
   - 話し手タイプ({SPEAKER_TYPE})と性別({SPEAKER_GENDER})に応じた適切な人物像
   - 話し手タイプに適した服装と背景設定
   - 正面向き、リップシンクに適した表情
   - 高品質、フォトリアリスティック
   - 日本人の特徴を持つ美しい人物
   - プレゼンテーションスタイル({PRESENTATION_STYLE})を反映した表情と雰囲気
   - 英語で作成

2a. **i2iプロンプト** ({PLANNING_DIR}/i2i-prompt.txt) - **speaker-type=customの場合のみ作成**
   - **重要**: キャラクターの外見・服装は完全に維持し、表情・背景・ポーズのみ調整
   - 基本構造: "Keep this character's exact appearance, clothing, and design unchanged. Adjust only: confident, friendly facial expression suitable for presentations, character facing directly forward toward the camera, front-facing pose, sophisticated cyber lounge with elegant neon accents, luxury tech environment with soft glowing elements."
   - キャラクター説明({CHARACTER_DESCRIPTION})がある場合は追加情報として簡潔に含める
   - **重要**: キャラクター説明が日本語の場合は必ず英語に翻訳してから含める
   - プレゼンテーションスタイル({PRESENTATION_STYLE})に応じた表情調整を含める
   - 英語で作成

3. **動画コンセプト** ({PLANNING_DIR}/video-concept.txt)
   - 話し手タイプ({SPEAKER_TYPE})に適した自然な話し方
   - プレゼンテーションスタイル({PRESENTATION_STYLE})に合った身振り手振り
   - プレゼンテーションスタイル({PRESENTATION_STYLE})を反映した雰囲気
   - リップシンクに最適な口の動き
   - 英語で作成

4. **音声設定** ({PLANNING_DIR}/voice-settings.json)
   - 話し手の性別({SPEAKER_GENDER})とプレゼンテーションスタイル({PRESENTATION_STYLE})に適した音声設定
   - プレゼンテーションスタイル({PRESENTATION_STYLE})に合った話速と感情設定
   - 話し手タイプ({SPEAKER_TYPE})に適したトーンの設定
   - JSON形式で作成
   **男性向け例**: {"voice_id": "Casual_Guy", "pitch": 0, "language_boost": "Japanese", "emotion": "happy", "speed": 1.1}
   **女性向け例**: {"voice_id": "Calm_Woman", "pitch": 2, "language_boost": "Japanese", "emotion": "neutral", "speed": 1.0}
   
   **利用可能な音声オプション** (`module-workflow/kamuicode/kamuicode-usage.md` 参照):
   - **男性voice_id**: Deep_Voice_Man, Casual_Guy, Patient_Man, Young_Knight, Determined_Man, Decent_Boy, Imposing_Manner, Elegant_Man
   - **女性voice_id**: Wise_Woman, Inspirational_girl, Calm_Woman, Lively_Girl, Lovely_Girl, Abbess, Sweet_Girl_2, Exuberant_Girl
   - **性別不明**: Friendly_Person
   - **emotion**: happy, sad, angry, fearful, disgusted, surprised, neutral
   - **pitch(話速)**: -12〜12, **speed(音程)**: 0.5-2.0, **vol(音量)**: 0-10

5. **コンテンツタイトル** ({PLANNING_DIR}/content-title.txt)
   - 魅力的で内容を的確に表すタイトル
   - 1行で簡潔に（30文字程度まで）
   - 英語で作成（バナー表示用）
   - 話し手タイプ({SPEAKER_TYPE})に適したタイトル表現

6. **コンテンツ要約** ({PLANNING_DIR}/content-summary.txt)
   - 3-5文でコンテンツの要点をまとめる
   - プレゼンテーションスタイル({PRESENTATION_STYLE})に合った表現

7. **企画書** ({PLANNING_DIR}/content-plan.md)
   - 全体の企画内容をMarkdown形式でまとめる
   - 各要素の意図と狙いを説明
   - 話し手タイプと性別の選択理由を記載

**重要な注意点**:
- プレゼンテーション原稿は{TARGET_LANGUAGE}で作成
- 画像・動画プロンプトは英語で作成
- **コンテンツタイトルは英語で作成**（バナー表示用）
- リップシンクを前提とした内容にする
- {PRESENTATION_STYLE}の一貫性を保つ
- **性別・国籍統一**: 画像、動画、音声すべて{SPEAKER_GENDER}の日本人で統一すること
- **話し手タイプの一貫性**: {SPEAKER_TYPE}に応じた適切な設定・表現・背景を選択すること
- 実際のプロフェッショナルなプレゼンテーションのような仕上がりを目指す
