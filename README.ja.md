[WIP] CloudFlow
=========

CloudFlowはマルチインスタンスコーディングを簡単にします。
インスタンス間通信のためにインスタンス/ロール毎にコードを書く必要はありません。全て、単一のコードとして書くことが出来ます。

また、CloudFlowはSQS Queueを通じてメソッドを呼びます。ですので、インスタンスはお互いを知る必要がなく、従って一切の設定が必要ありません。
同様の理由により、インスタンスをコピーすればそのままスケール出来ます。

```ruby
flow = CloudFlow.new("example") # then it uses SQS queue: 'cloudflow_example'

flow.on :first do
  puts "first"
  flow.second("By the way, I'm feeling lucky.")
end

flow.on :second do |args|
  puts "second"
  puts "  arg received: #{args}"
  flow.third
end

flow.on :third do
  puts "last!"
end

flow.first

flow.start # start polling the queue.

# => first 
# => second
# =>   arg received: By the way, I'm feeling lucky.
# => last!
```

Motivation
=========

インスタンスを跨いだコードを書くのがとんでもなく面倒だったので書きました。

普通ならば、APIやRPCを用いてインスタンス間通信をするかと思いますが、色々面倒です。通信スキーマを定義したり、そもそもポート空けて通信待ち受けないといけなかったり…
もし、インスタンスが死んでいれば呼び出しも失敗します。そうすると、呼び出し側にエラーハンドリングが絡んでくる。
面倒すぎるので、全て一元的にキューにメソッド呼び出しを集め、インスタンスはそれらを随時取ってくるようにすることで、シンプルにコードを書くことが出来ます。

メリットは、

- お互いのインスタンスを知る必要が無い。従って、一切の設定作業が不要
- インスタンスを足すだけでスケール出来る。設定不要。
- 通信を受ける必要がないのでセキュリティの心配が減る。
- APIやRPCと違い、インスタンスが死んでいてもエラーにならない。ただ、キューが溜まるだけ。（Fail-Safe）
- 全体的に疎結合になる。

Install
=========

`gem 'cloud_flow'`

Please note `cloud_flow` is currently WIP.
It's interface can be changed without any anounce.

Usage
=========

- Set AWS key as following. Putting it on `config/aws.rb` and `require_relative 'config/aws'` is recommended way.

```ruby
AWS.config(
  access_key_id: "ACCESS_KEY"
  secret_access_key: "SECRET_KEY"
  # sqs_endpoint: "sqs.ap-northeast-1.amazonaws.com" # if needed.
)
```

- `require 'cloud_flow'` and enjoy!


Document
=========

http://rubydoc.info/gems/cloud_flow

Scalability
=========

Just copy an instance to scale. Each instances has same environment.

TODO
=========
1. Write more test. (Especially about handling SQS) Currently I wrote about only parsing a message. 
2. Write better doc.

Want to do
========
1. Provide a way to handle ActiveRecord objects easier. Because now you can pass args only String or Number.
2. Provide a way to pass a callback block.
