## 依存

Docker Engine

## サーバー立ち上げの手順

### 1. `./build_server.sh` でコンテナイメージのビルド
### 3. `./run_server.sh` でコンテナを実行

## ワールド設定

(`./run_server.sh`がマウントしてないため、コンテナ実行時にマウントすべきだった)

### 1.  (ホスト側) 起動しているコンテナのbashを実行し、コンテナ内の作業に切り替える

```sh
docker exec -it palworld /bin/bash
```

### 2. `/app/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini`を編集する。

コンテナにはエディタが含まれないため、`sed`コマンドによる置換を行う。

下記は例

```sh
sed -i 's/DeathPenalty=[a-z|A-Z]*/DeathPenalty=ItemAndEquipment/g' /app/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
```

## アップデートの手順

1. (ホスト側) 起動しているコンテナのbashを実行し、コンテナ内の作業に切り替える

```sh
docker exec -it palworld /bin/bash
```

2. (コンテナ内) `/steamapps`ディレクトリに移動し、下記コマンドを実行。新しいバージョンがインストールされる。この操作はDockerfile内にも記載がある。

```sh
cd /steamapps
./steamcmd.sh +force_install_dir '/app/PalServer/' +login anonymous +app_update 2394010 validate +quit
```

3. (コンテナ内) コンテナから出る

```sh
exit
```

4. (ホスト側) 下記コマンドでサーバーを再起動する

```sh
docker restart palworld
```
