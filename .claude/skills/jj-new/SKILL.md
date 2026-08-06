---
name: jj-new
description: jj newを実行して新しいjjチェンジを作成する。現在のチェンジ(@)のdescriptionが未設定の場合は、変更内容を確認してConventional Commitsスタイルの適切なdescriptionを設定してから実行する。ユーザーが「jj new」「jjで新しいチェンジを作りたい」「現在の作業を区切って次へ進みたい」と言った時に必ず使用すること。
allowed-tools: Bash(jj:*)
---

現在のjjチェンジ（`@`）に対して、descriptionがセットされていなければ適切なdescriptionを設定し、その後`jj new`を実行してください。

## 実行手順

### Step 1: 現在のdescriptionを確認

以下のコマンドで`@`のdescriptionを取得する：

```bash
jj log -r @ --no-graph -T 'description'
```

### Step 2: descriptionの有無を判定

- 出力が空または空白のみ → Step 3へ進む
- descriptionがセットされている → Step 4へスキップ

### Step 3: 変更内容を確認してdescriptionを設定

#### 3.1 変更内容を確認

```bash
jj diff --summary
jj diff
```

#### 3.2 Conventional Commitsスタイルでdescriptionを決定

変更内容に合わせて以下のプレフィックスを使用：
- `feat:` 新機能の追加
- `fix:` バグの修正
- `refactor:` リファクタリング
- `docs:` ドキュメントの変更
- `test:` テストの追加・修正
- `chore:` その他のメンテナンス作業

#### 3.3 descriptionを設定

```bash
jj describe -m "適切なメッセージ"
```

### Step 4: jj newを実行

```bash
jj new
```

設定したdescriptionと実行結果をユーザーに報告してください。
