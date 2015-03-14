Booklog Reminder
================

## 概要 / Description
ブクログの「読みたい本」からランダムに本を選んでリマインドメールを送るためのRubyスクリプト。

## 使い方 / Usage

bundle install した後、cronに以下のようなコマンドを仕込んでおきましょう

```
0 7 * * * cd /your/path/booklog-reminder && ./booklog-reminder --user (あなたのユーザ名) --sender (差出人メールアドレス) --recipient (宛先のメールアドレス)
```

ディレクトリ配下に設定を書き込んだ.envを置いておくと自動的に読み込みます。.env.sampleファイルを参考にしてください。

## ライセンス / License

MITライセンスです。
