## 依存

Docker Engine

## サーバー立ち上げの手順

1. `./build_server.sh` でコンテナイメージのビルド
2. `./run_server.sh` でコンテナを実行

## アップデートの手順

1. コンテナ内のbashを起動する。

```sh
docker exec -it palworld /bin/bash
```

2. `/steamapps`ディレクトリに移動し、下記コマンドを実行。新しいバージョンがインストールされる。これはDockerfile内にも記載がある。

```sh
./steamcmd.sh +force_install_dir '/app/PalServer/' +login anonymous +app_update 2394010 validate +quit
```

3. コンテナから出て、下記コマンドでサーバーを再起動する

```sh
docker restart palworld
```
