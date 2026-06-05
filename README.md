# AI Project Template files

this project contains initial files using ai development.

## Install and Setup

### Install Resources files

```bash
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

### takt
```bash
npm install -g takt
```

# gitignore-merge
```bash
go install github.com/taku-o/gitignore-merge/cmd/gitignore-merge@latest
```

### cc-sdd
```bash
npx cc-sdd@latest --lang ja
```

### 開発手順
```
## プロジェクトの解析
## (最初か、プロジェクトの構成が変わった時に実行する。)
/kiro-steering

## プロジェクトの要件を作成＋要件の検証
/kiro-spec-requirements "{プロジェクトの要件}"
/kiro-validate-gap {feature}
/kiro-approve-req {feature}

## 設計を作成＋設計の検証
/kiro-spec-design {feature}
/kiro-validate-design {feature}
/kiro-approve-design {feature}

## タスク一覧を作成＋要件・設計・タスクの検証
/kiro-spec-tasks {feature}
/kiro-review-spec {feature}
/kiro-approve-task {feature}

## 指定タスクを実装する (直接 or takt経由)
/kiro-impl {feature} {task-number}
takt --task "/kiro-impl {feature} {task-number}"

## 実装レビュー
/kiro-validate-impl {feature} {task-number}
/code-review
/simplify-loop
/kiro-complete-tasks {feature} {task-number}

## 全てのタスクが完了したらPull Requestを作成
/commit-commands:commit-push-pr

## 作成したPull Requestに対してレビューを通す
/review {pull-request-number}
```
