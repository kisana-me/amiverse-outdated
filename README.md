# Amiverse

インターネットの要素をごちゃまぜにした全く新しいソーシャルメディアです。

OSSではないですが、[インストール手順](https://github.com/Kisana528/amiverse/wiki/Install)を見れば皆さん簡単に利用できます。

[Wiki](https://github.com/Kisana528/amiverse/wiki)の方にいろいろ書いてます。







# 本番環境構築方法

## ダウンロード
クローンします
```
git clone https://github.com/Kisana528/amiverse.git
```
権限等を適切に設定してください
```
chown -R user:group amiverse
```
移動します
```
cd amiverse
```
念の為フェッチ
```
git fetch origin main
```
念の為リセット
```
git reset --hard origin/main
```

## 作成
app内bashに入る
```
docker compose run --rm app bash
```
（コンテナ内）
```
bundle
```
credentials作成
```
EDITOR="mate --wait" rails credentials:edit
```
db作成とマイグレート
```
rails db:create && rails db:migrate
```
ブラウザで[MiniIO Console](http://localhost:9001/)を開きバケットと、
プレフィックス'variants'の読み取り権限付与と、リージョンを設定。
seedあれば./src/db/seeds.rbを保存後
```
rails db:seed
```
コンテナ内から出ます
```
exit
```
（コンテナ外）
```
docker compose down
```
Docker Composeで起動
```
docker compose up -d --build
```
以上で完了。

## メンテナンス
compose起動中app内に入るには
```
docker container exec -it amiverse-app-1 bash
```
ログを確認するには  
```
docker compose logs --follow --tail '1000'
```












# 実装予定
- Redis(揮発性メモリ上でデータ管理)
- Es(検索最適化)

# 開発ルール
## ブランチ
- main - プロダクションとして公開するもの
- develop - 開発中
- release - 次期main候補
- feature/* - 新規開発
- hotfix/* - バグ対処
- fix/* - 改善
- support/* - 過去バージョン
## コミットメッセージ
```
[種別] 内容の要約
内容...
```
### 種別一覧
- fix
- hotfix
- add
- update
- change
- clean
- disable
- remove
- upgrade
- revert