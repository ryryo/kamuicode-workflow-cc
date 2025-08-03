# kamuicode Workflows - Public Components

[kamuicode Workflows](https://github.com/khomma/kamuicode-workflow)をベースにカスタマイズしたワークフローコンポーネント集です。

## 概要

このリポジトリは、AI技術を活用した各種コンテンツ生成ワークフローの公開コンポーネントを含んでいます。プロンプトテンプレート、ドキュメント、サンプルスクリプトなど、再利用可能なコンポーネントを提供します。

## 🎥 デモページ

**[→ Live Demo](https://ryryo.github.io/kamuicode-workflow-cc/demo/index.html)** - プレゼンター動画生成ワークフローの実際の成果物をご覧いただけます。

## 公開コンポーネント

### 🎬 [Presenter Video Generation](./workflow/presenter-video-generation/)
プレゼンター動画を自動生成するワークフロー。7種類の話し手タイプに対応し、リップシンクや字幕生成機能を含みます。

## 必要な環境

- Claude Code SDK
- kamuicode MCP
- ffmpeg
- Python 3.x
- その他、各ワークフロー固有の要件

## 🚀 クイックスタート

1. **初期設定**: [SETUP.md](./SETUP.md) を参照してAPIキーとMCP設定を行う
2. **ワークフロー選択**: 各ワークフローのディレクトリにある README.md を参照

## 貢献について

詳細は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。

## ライセンス

このプロジェクトはMITライセンスで公開されています。

ベースプロジェクト [kamuicode Workflows](https://github.com/khomma/kamuicode-workflow) は以下のライセンスの下で公開されています：

```
MIT License

Copyright (c) 2025 Kenta Homma

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 謝辞

このプロジェクトは、Kenta Homma氏による kamuicode Workflows プロジェクトをベースに開発されました。元プロジェクトの優れたアーキテクチャとモジュール設計に感謝いたします。