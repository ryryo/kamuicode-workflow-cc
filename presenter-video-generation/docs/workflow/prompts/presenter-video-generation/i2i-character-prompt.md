# i2i Character Prompt Template for Custom Speaker Type

このプロンプトは、`speaker-type=custom`の場合に既存のキャラクター画像を基にプレゼンター画像を生成するために使用されます。

## 入力変数

- `{CHARACTER_DESCRIPTION}`: ユーザーが提供したキャラクターの説明（オプション）
- `{SPEAKER_PERSONALITY}`: speaker_typeから導出された性格（custom時は標準的なプレゼンター性格）
- `{PRESENTATION_CONTEXT}`: プレゼンテーションのコンテキスト（話す内容の雰囲気）
- `{ASPECT_RATIO}`: 画面比率（1:1, 9:16, 16:9など）

## i2i Prompt Template

```
Transform this character into a professional presenter while maintaining their unique visual identity. {CHARACTER_DESCRIPTION}

Key requirements:
- Preserve the character's core visual features and style
- Adjust pose to be presenter-appropriate: standing/sitting with confident posture
- Expression should be {SPEAKER_PERSONALITY}
- If the character has distinctive clothing, maintain its style but ensure it looks presentable
- Background should be simple and professional, suitable for presentations
- Lighting should be clear and flattering for video presentations
- The character should appear ready to speak to an audience

Presentation context: {PRESENTATION_CONTEXT}

Technical specifications:
- Aspect ratio: {ASPECT_RATIO}
- High quality, suitable for video generation
- Clear facial features for lip-sync compatibility
- Professional presenter appearance while retaining character identity
```

## 使用例

### アニメキャラクターの場合
```
Transform this character into a professional presenter while maintaining their unique visual identity. Blue-haired anime character with cheerful personality

Key requirements:
- Preserve the character's core visual features and style
- Adjust pose to be presenter-appropriate: standing/sitting with confident posture
- Expression should be friendly and welcoming, with a warm smile
- If the character has distinctive clothing, maintain its style but ensure it looks presentable
- Background should be simple and professional, suitable for presentations
- Lighting should be clear and flattering for video presentations
- The character should appear ready to speak to an audience

Presentation context: Introducing new smartphone features to general audience

Technical specifications:
- Aspect ratio: 9:16
- High quality, suitable for video generation
- Clear facial features for lip-sync compatibility
- Professional presenter appearance while retaining character identity
```

### リアルな人物の場合
```
Transform this character into a professional presenter while maintaining their unique visual identity. Professional woman in business attire

Key requirements:
- Preserve the character's core visual features and style
- Adjust pose to be presenter-appropriate: standing/sitting with confident posture
- Expression should be professional and authoritative, conveying expertise
- If the character has distinctive clothing, maintain its style but ensure it looks presentable
- Background should be simple and professional, suitable for presentations
- Lighting should be clear and flattering for video presentations
- The character should appear ready to speak to an audience

Presentation context: Corporate training on online learning platform

Technical specifications:
- Aspect ratio: 16:9
- High quality, suitable for video generation
- Clear facial features for lip-sync compatibility
- Professional presenter appearance while retaining character identity
```

## 注意事項

1. **キャラクターの個性維持**: 元のキャラクターの特徴的な要素（髪色、服装スタイル、全体的な雰囲気）は可能な限り維持する
2. **プレゼンター適性**: ポーズ、表情、背景はプレゼンテーションに適したものに調整する
3. **リップシンク対応**: 顔の特徴がはっきりと見え、口の動きが追跡できるようにする
4. **プロフェッショナル性**: キャラクターの個性を保ちながら、信頼できるプレゼンターとしての印象を与える