---
name: write-claude-code-fnc
description: Claude Codeのスキル・プラグイン・サブエージェント・フック・設定（settings.json）を新規作成・修正するときに発動するスキル。「スキルを作って」「スキルを作成」「スキルの作成」「スキルを修正」「スキルの修正」「スキルを変更」「スキルを更新」「プラグインを追加」「エージェントを定義」「フックを設定」「設定を変更」など、Claude Code自体を拡張・カスタマイズする作業のときは必ずこのスキルを使う。「スキルを作成」「スキルの修正」といったワードが含まれている場合、それはClaude Codeのスキル機能に関する作業と判断してこのスキルを発動する。作業前に公式ドキュメントを参照して正しい置き場所・フォーマットを確認してから実装する。
allowed-tools: Bash(mkdir *) Bash(cp *) Bash(ls *) Read Write Edit WebFetch
---

# write-claude-code-fnc

Claude Code の機能を新規作成・修正するスキル。作業前に公式ドキュメントを参照し、正しいファイル構造・配置場所を確認してから実装する。

## 作業前の必須ステップ

作業内容に応じて対応するドキュメントページを **WebFetch で取得してから** 実装を始める。ドキュメントなしに過去の知識だけで作業してはいけない（仕様が変わっている可能性がある）。

| 作業種別 | 参照ページ |
|---------|-----------|
| スキル作成・修正 | `https://code.claude.com/docs/en/skills` |
| プラグイン作成・配布 | `https://code.claude.com/docs/en/plugins` |
| サブエージェント定義 | `https://code.claude.com/docs/en/sub-agents` |
| フック設定 | `https://code.claude.com/docs/en/hooks` |
| settings.json 変更 | `https://code.claude.com/docs/en/settings` |
| MCP サーバー追加 | `https://code.claude.com/docs/en/mcp` |

複数の種別にまたがる作業は該当するページをすべて取得する。

---

## ファイル配置の早見表

### スキル（Skills）

| スコープ | パス |
|---------|------|
| プロジェクト | `.claude/skills/<name>/SKILL.md` |
| ユーザー（全プロジェクト共通） | `~/.claude/skills/<name>/SKILL.md` |

**最小構成:**
```
<name>/
└── SKILL.md   # frontmatter + 手順
```

**拡張構成:**
```
<name>/
├── SKILL.md
├── references/   # 詳細ドキュメント（必要時のみ読み込み）
├── scripts/      # 実行スクリプト
└── assets/       # テンプレート等
```

### プラグイン（Plugins）

スキル・エージェント・フックをまとめて配布したい場合に使う。

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json   # マニフェスト（name/description/version）
├── skills/           # <skill-name>/SKILL.md
├── agents/           # <agent-name>.md
├── hooks/
│   └── hooks.json
└── .mcp.json         # MCP サーバー設定（必要な場合）
```

> ⚠️ `skills/` `agents/` `hooks/` は **プラグインルート直下** に置く。`.claude-plugin/` の中には `plugin.json` のみ。

### サブエージェント（Sub-agents）

| スコープ | パス |
|---------|------|
| プロジェクト | `.claude/agents/<name>.md` |
| ユーザー | `~/.claude/agents/<name>.md` |

### フック（Hooks）

| 配置先 | 用途 |
|-------|------|
| `.claude/settings.json` の `hooks` キー | プロジェクト共有フック |
| `~/.claude/settings.json` の `hooks` キー | 全プロジェクト共通フック |
| プラグインの `hooks/hooks.json` | プラグインにバンドル |

### settings.json

| スコープ | パス | 用途 |
|---------|------|------|
| ユーザー | `~/.claude/settings.json` | 全プロジェクト共通 |
| プロジェクト | `.claude/settings.json` | チーム共有（git管理） |
| ローカル | `.claude/settings.local.json` | 個人設定（gitignore） |

優先順位（高→低）: マネージド > ローカル > プロジェクト > ユーザー

---

## SKILL.md の書き方

```yaml
---
name: skill-name              # 表示名（省略可、デフォルトはディレクトリ名）
description: |                # Claude がいつ使うかを説明。ここが自動発動の主要トリガー
  何をするスキルか。
  「〜したい」「〜を確認」など発動条件となるフレーズも含める。
disable-model-invocation: true  # 手動 /name のみ発動させたい場合
allowed-tools: Bash(git *) Read  # 承認なしで使えるツールを限定
context: fork                 # サブエージェントで独立実行させたい場合
---

# スキル本文（Markdown）
```

### `description` 作成のポイント
- 「何をするか」だけでなく「いつ使うか」のフレーズも入れる
- 自動発動させたい場合は発動条件のキーワードを入れる
- `disable-model-invocation: true` にしたら description は不要でも OK

---

## サブエージェント（agents/<name>.md）の書き方

```markdown
---
name: agent-name
description: このエージェントの説明。Claude がいつ委譲するかの基準になる。
model: claude-haiku-4-5-20251001   # 軽量タスクはコスト削減のため Haiku を使う
allowed-tools: Read Bash(grep *)   # 使えるツールを制限
---

# システムプロンプト
エージェントの専門領域と振る舞いを定義する。
```

---

## hooks.json の書き方

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs npm run lint:fix"
          }
        ]
      }
    ]
  }
}
```

フックイベント種別: `PreToolUse` / `PostToolUse` / `Notification` / `Stop` / `SessionStart`

---

## 実装の手順

1. **ドキュメント取得** — 上記の早見表から対応ページを WebFetch で取得する
2. **スコープ確認** — プロジェクト限定か全プロジェクト共通かをユーザーに確認（曖昧なら聞く）
3. **ディレクトリ作成** — `mkdir -p` で必要なパスを作成
4. **ファイル作成** — ドキュメントの仕様に沿って作成
5. **動作確認案内** — 再起動不要か `/reload-plugins` が必要かを伝える

### 再起動・リロードが必要な変更

| 変更内容 | 対応 |
|---------|------|
| スキルのテキスト変更 | 不要（ライブ更新） |
| 新しいスキルディレクトリの追加 | セッション再起動が必要 |
| プラグインの変更 | `/reload-plugins` |
| settings.json の多くのキー | 自動リロード |
| `model` 設定 | `/model` コマンドで切り替え可 |
