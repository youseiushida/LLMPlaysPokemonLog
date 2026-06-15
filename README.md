# FablePlaysPokemon — Claude プレイログ

ClaudeにポケモンFireRedを**殿堂入り（Hall of Fame）まで自力でクリアさせる**プロジェクト
「FablePlaysPokemon」の、Claude Code セッションログを集めたリポジトリです。

`/goal` で次のゴールを与え、Stopフックで途中停止できないようにして、Claudeに延々とプレイさせています。

> **Beat Pokémon FireRed by entering the Hall of Fame. Use only screen observation and controller CLI inputs.**
> （画面の観察とコントローラCLI入力だけを使って、殿堂入りでFireRedをクリアせよ）

## 構成

同じFireRed攻略を**2台のマシンにまたがって**続けた記録です。時系列は **nezow → ushid**。

| フォルダ | マシン | 役割 |
| --- | --- | --- |
| `c--Users-nezow-Documents-FablePlaysPokemon/` | nezow（私用ノートPC） | プレイ開始。ここで遊ばせ始めた |
| `C--Users-ushid-Documents-FablePlaysPokemon/` | ushid（自宅サーバー） | nezow の続きを引き継いで継続プレイ |

ノートPCで始めたプレイを、そのまま自宅サーバーに引き継いで走らせ続けています。
コンテキストが溢れるたびにセッションを継続（`continue`）しながら、ゴールに向かって動き続けるのが特徴です。

## ログについて

- 各 `*.jsonl` が Claude Code の1セッションの記録です（フォルダはセッションごとの作業ディレクトリ）。
- サイズの大きい `.jsonl`（数十〜数百MB）が、実際に長時間プレイし続けた本番セッションです。
- 小さいログには、立ち上げ時の挨拶・動作確認や、配信まわり（statusline を受け取って OBS の配信画面に組み込む等）の検討も含まれます。

# gptokemon — Codex GPT 5.5 プレイログ

Claude にやらせた FablePlaysPokemon と同様に、Codex GPT 5.5 にポケモン FireRed をプレイさせたログを `gptokemon/` にまとめています。
同じく画面観察とコントローラ CLI 入力を使い、殿堂入りを目標に継続プレイさせた記録です。

`gptokemon/manifest_sessions.csv` と `gptokemon/manifest_sessions.tsv` は収集したセッションの一覧です。
`sessions_mentions/` には gptokemon への言及があるセッション、`sessions_cwd/` には作業ディレクトリ由来で拾ったセッションを置いています。
`repo_snapshot/` にはプレイ時点のリポジトリ状態のスナップショットを含めています。
