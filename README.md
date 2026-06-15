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
