<div id="top"></div>

# Task App Back

## **概要**
Task App Back は、**Ruby on Rails** を使用した**タスク管理アプリのバックエンドAPI**です。  
フロントエンドとは **REST API** で通信し、ユーザー認証・タスク管理・フォルダ管理などの機能を提供します。

---

## **使用技術一覧**

<p style="display: inline">
  <img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Rails-CC0000.svg?logo=ruby-on-rails&style=for-the-badge">
  <img src="https://img.shields.io/badge/-PostgreSQL-336791.svg?logo=postgresql&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Devise-6E4C13.svg?logo=rubygems&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Docker-1488C6.svg?logo=docker&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Render-46E3B7.svg?logo=render&style=for-the-badge">
</p>

---

## **目次**

1. [Ruby のバージョン](#ruby-のバージョン)
2. [システム依存関係](#システム依存関係)
3. [環境変数の設定](#環境変数の設定)
4. [データベースのセットアップ](#データベースのセットアップ)
5. [テストの実行](#テストの実行)
6. [デプロイ手順](#デプロイ手順)
7. [APIエンドポイント](#apiエンドポイント)

---

## **Ruby のバージョン**
| 技術                | バージョン |
|---------------------|----------|
| Ruby               | 3.2.3    |
| Rails              | 6.1.7.8  |

このバージョンを使用してください。

---

## **システム依存関係**
このアプリケーションを動作させるには、以下のソフトウェアが必要です。

- **Docker**
- **PostgreSQL**

---

## **環境変数の設定**
このプロジェクトは環境変数を使用します。  
`.env` ファイルを作成し、以下のように設定してください。

```sh
DATABASE_URL=postgres://user:password@localhost:5432/task_app
RAILS_ENV=development
SECRET_KEY_BASE=$(rails secret)
```

⚠️ **`.env` ファイルは `.gitignore` に追加してください！**

---

## **データベースのセットアップ**
1. **リポジトリをクローン**
   ```sh
   git clone https://github.com/deforu/task-app-back.git
   cd task-app-back
   ```
2. **Docker環境を起動**
   ```sh
   docker-compose up --build
   ```
3. **データベースを作成 & マイグレーション**
   ```sh
   docker-compose exec api rails db:create db:migrate db:seed
   ```
4. **サーバーを起動**
   ```sh
   docker-compose exec api rails server -b 0.0.0.0
   ```

---

## **テストの実行**
テストを実行するには、以下のコマンドを使用してください。

```sh
docker-compose exec api rails test
```

---

## **サービスの設定**
このアプリケーションでは、以下のサービスを利用します。

- **ジョブキュー:** Sidekiq（未導入の場合、`DelayedJob` などを検討）
- **キャッシュ:** Redis
- **ストレージ:** Active Storage (S3, ローカルストレージ)

---

## **デプロイ手順**
このアプリケーションは **Render** にデプロイされています。

| サービス | URL |
|----------|----------------------------------------------|
| バックエンドAPI（Render） | [task-app-back API](https://task-app-back-ws1o.onrender.com/api/v1/todos) |

デプロイする際の手順:

1. **Render で PostgreSQL を設定**
2. **環境変数を設定**
3. **`git push` で自動デプロイ**

---

## **APIエンドポイント**

### **1. 認証関連**
| メソッド | エンドポイント | 説明 |
|----------|---------------------------|----------------|
| `POST`   | `/api/v1/auth/sign_in`            | ログイン |
| `POST`   | `/api/v1/auth/sign_up`            | ユーザー登録 |
| `DELETE` | `/api/v1/auth/sign_out`           | ログアウト |
| `GET`    | `/api/v1/auth/validate_token`     | トークン認証 |
| `GET`    | `/api/v1/auth/sessions`           | ログイン状態確認 |

---

### **2. ユーザー管理**
| メソッド | エンドポイント | 説明 |
|----------|---------------------------|----------------|
| `GET`    | `/api/v1/users/me` | 自分のユーザー情報取得 |
| `PUT`    | `/api/v1/users/avatar` | プロフィール画像更新 |
| `GET`    | `/api/v1/users/:id/avatar` | 特定ユーザーのプロフィール画像取得 |
| `PUT`    | `/api/v1/users/:id` | ユーザー情報更新 |

---

### **3. タスク管理**
| メソッド | エンドポイント | 説明 |
|----------|----------------------|----------------------------|
| `GET`    | `/api/v1/todos`             | タスク一覧取得 |
| `POST`   | `/api/v1/todos`             | タスク作成 |
| `PATCH`  | `/api/v1/todos/:id`         | タスク更新 |
| `DELETE` | `/api/v1/todos/:id`         | タスク削除 |

追加のエンドポイント：
| メソッド | エンドポイント | 説明 |
|----------|----------------------|----------------------------|
| `GET`    | `/api/v1/todos/important` | 重要なタスクの取得 |
| `GET`    | `/api/v1/todos/today`     | 今日のタスクの取得 |
| `GET`    | `/api/v1/todos/completed` | 完了済みタスクの取得 |

---

### **4. フォルダ管理**
| メソッド | エンドポイント | 説明 |
|----------|-----------------------|----------------|
| `GET`    | `/api/v1/folders`            | フォルダ一覧取得 |
| `POST`   | `/api/v1/folders`            | フォルダ作成 |
| `PATCH`  | `/api/v1/folders/:id`        | フォルダ更新 |
| `DELETE` | `/api/v1/folders/:id`        | フォルダ削除 |
| `GET`    | `/api/v1/folders/:folder_id/todos` | 特定フォルダのタスク一覧 |
| `POST`   | `/api/v1/folders/:folder_id/todos` | 特定フォルダにタスク作成 |

<p align="right">(<a href="#top">トップへ</a>)</p>
