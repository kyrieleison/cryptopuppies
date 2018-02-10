# Crypto Puppies

## Setup

Ethereum 開発フレームワークである Truffle をインストールします。

```
% npm install -g truffle
```

Ganache を使用して、開発用のローカル Ethereum ノードを起動します。

```
% git clone git@github.com:trufflesuite/ganache.git
% cd ganache
% npm install
% npm start
```

## Deploy to development

```
% truffle migrate --network development
```

## Debug

```
% truffle console --network development
```

## Run

Ganache を起動し、コントラクトをデプロイした上で、サーバを起動します。
`localhost:8080` からアプリケーションにアクセスできます。

```
cd build
ruby -run -e httpd . -p 8080
```
