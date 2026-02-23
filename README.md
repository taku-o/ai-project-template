# AI Project Template files

this project contains initial files using ai development.

## Install and Setup

### Install Resources files

```
curl -fsSL https://raw.githubusercontent.com/taku-o/ai-project-template/master/install.sh | sh
```

### Install Package Application
* Cursor
    * https://cursor.com/ja?from=home

### Homebrew
```bash
/bin/bash -c"$(curl -fsSLhttps://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
$(/opt/homebrew/bin/brew shellenv)
```

### GitHub CLI
```bash
brew install gh
gh auth login
gh auth status
```

### nvm
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
nvm ls-remote
nvm install v22.14.0
nvm use v22.14.0
nvm alias default v22.14.0
```

* add .bashrc
```bash
if [ -f ~/.nvm/nvm.sh ]
then
  source ~/.nvm/nvm.sh
fi
```

### Claude Code
```bash
npm install -g @anthropic-ai/claude-code
```

### uv
```bash
brew install uv
```

### Serena
* use this command at project directory.
```bash
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --enable-web-dashboard false --project $(pwd)
```

* use some times, to update serena index files.
```bash
uvx --from git+https://github.com/oraios/serena index-project
```

## cc-sdd

cc-sddは仕様駆動開発を行うためのツールです。
Cursor、Claude Code上で作業します。

### コマンド
```
## プロジェクトの解析
## (最初か、プロジェクトの構成が変わった時に実行する。)
/kiro:steering

## プロジェクトの要件・設計・タスクを作成(一括)
/kiro/spec-init "{プロジェクトの要件}"

## プロジェクトの要件を作成
/kiro:spec-requirements "{プロジェクトの要件}"

## 設計を作成
/kiro:spec-design

## タスク一覧を作成
/kiro:spec-tasks

## 指定タスクを実行する
/kiro:spec-impl "{タスク}"
```

### 利用手順例. Cursor上で作業 (ドキュメントの品質が良いため)
```
## プロジェクトを作ったら最初に1回実行
/kiro:steering

## プロジェクトの要件を作成
/kiro:spec-requirements "https://github.com/taku-o/go-webdb-template/issues/3 に対応するための要件を作成してください。GitHub CLIは入っています。"
think.

## 要件定義書作成計画が表示された場合は
要件定義書を作成してください。

## 要件定義書の内容を確認したら
要件定義書を承認します。

## 設計を作成
/kiro:spec-design

## 設計書の内容を確認したら
設計書を承認します。

## タスク一覧を作成
/kiro:spec-tasks

## タスク一覧の内容を確認したら
タスクリストを承認します。

この要件の作業用のgitブランチを切ってください。
ここまでの作業をcommitしてください。
```

### 利用手順例. Claude Code上で作業 (作業速度が速いため)

```
## 実装開始
/kiro:spec-impl 0003-gorm-introduction

## 実装が完了したらPull Request作成
ここまでの修正をcommitしてください。
その後、https://github.com/taku-o/go-webdb-template/issues/57 に対して
pull requestを作成してください。

## 作成して貰ったPull Requestに対してレビューを通す
/review 61
```

