# 江ノ電運用報告文面ツール EER_unyo_reporter

江ノ電運用報告文面ツールのメンテナンスを行うためのリポジトリ。

## 本番環境
https://enodenwiki.web.fc2.com/

## バージョン更新の自動化
いちいちバージョンを書き換えるのが面倒なので、特定バージョンのファイルを自動で書き出すように改修した。
従来のyyyymmdd表記はRELEASE_DATEという文字列に書き換わっている。

### 前提

- shellコマンドを実行可能であること
 - OSがUbuntuなどのLinuxマシンである
 - Windowsの場合、たとえば[Git bash](https://git-scm.com/downloads/win)などを利用する。
- powershell が実行可能であること。
  ※今後CIで勝手にデプロイ出来たらいいなという思いもあって、UNIX環境でも動くように考慮はしたがテストしていない。


### build.sh内部仕様
1. htmlファイルのRELEASE_DATEを実行日(yyyymmdd形式)に書き換える。
2. ./out/index.html を作成する。
3. ./release/index_yyyymmdd.zip に固めて配置する

### リリース手順
1. build.shを実行する。
3. ./dist/index.html が作られる。
4. ./release/index_yyyymmdd.zipをダウンロードする
5. 中に入っているZipをWEBサーバーに配置し公開する。

