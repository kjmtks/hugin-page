# コンテンツの記述について

## ページの記述方法

ページを記述するファイルは，講義リポジトリ直下の `pages` ディレクトリ以下に保存する必要があります．

ページは Markdown または HTML でページを記述することができます．
どちらが使用されるかは拡張子により判断され，その対応関係は以下の通りです:

| 拡張子 | 記述方式 |
|-------|----------|
| .md   | Markdown |
| .htm  | HTML     |
| .html | HTML     |

さらに，Liquidライクなテンプレートエンジン [Scriban](https://github.com/scriban/scriban) が使用できます．
Scriban の仕様は [こちら](https://github.com/scriban/scriban/blob/master/doc/language.md) を参照してください．
Scriban から，Hugin独自の関数を呼び出したり，講義やユーザー等の情報，講義に設定されたパラメータを参照することができます．

## アクティビティの記述方法

執筆予定


## Hugin 独自の関数

### `is_null_or_whitespace`

文字列が `null` か空白であるか否かを判定する．

* 引数: `string` 判定する対象の文字列
* 戻り値: `bool` 文字列が `null` または空白であるならば `true`, そうでなければ `false`

使用例:
```
{%{ is_null_or_whitespace("this is not empty string") }%}
```

### `encode_html`

文字列をHTMLエンコードする．

* 引数: `string` エンコードする対象の文字列
* 戻り値: `string` エンコードされた文字列

使用例:
```
{{ encode_html("<>&\"") }}
```

### `decode_html`

HTMLエンコードされた文字列をデコードする．

* 引数: `string` デコードする対象の文字列
* 戻り値: `string` デコードされた文字列

使用例:
```
{{ decode_html("&lt;a href=&quot;foo?a=1&amp;b=1&quot;&gt;send&lt;a&gt;") }}
```

### `get_parameter`

ページの場合は講義パラメータを，アクティビティの場合は講義パラメータまたはページから渡されたパラメータを取得する．

* 引数: `string` パラメータの名前
* 戻り値: `object` パラメータの値

使用例:
```
{{ get_parameter("deadline") }}
```

### `date_time_to_string`

`date`, `datetime` 型の値をHugin標準の表示形式の文字列に変換する．

* 引数: `date` 対象の日付・日時型の値
* 戻り値: `string` 変換された文字列

使用例:
```
{{ date_time_to_string(date.now) }}
```

### `embed_text_file`

講義リポジトリから指定したテキストファイルを読み込む．

* 引数: `string` テキストファイルのパス
* 戻り値: `string` 変換された文字列

使用例:
```
{{ embed_text_file("page/index.md") }}
```


## 利用可能なプロパティ

### `lecture`
執筆予定

### `user`
執筆予定

### `users`
執筆予定

### `staffs`
執筆予定

### `students`
執筆予定

### `commit_info`
執筆予定

### `page_path`
執筆予定

### `rivision`
執筆予定

### `root`
執筆予定

## Hugin独自のオブジェクト

### Lecture
執筆予定

### User
執筆予定

### Role
執筆予定

### CommitInfo
執筆予定
