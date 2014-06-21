日本語(https://github.com/kaiinui/CloudFlow/blob/master/README.ja.md)

[![Gem Version](https://badge.fury.io/rb/cloud_flow.svg)](http://badge.fury.io/rb/cloud_flow)

[WIP] CloudFlow
=========

SQS Powered multi-instance coding made easy.

```ruby
flow = CloudFlow.new("example") # then it uses SQS queue: 'cloudflow_example'

flow.on :first do
  puts "first"
  flow.second("By the way, I'm feeling lucky.", "Really.")
end

flow.on :second do |feeling, how_much|
  puts "second"
  puts "  arg received: #{feeling} #{how_much}"
  flow.third
end

flow.on :third do
  puts "last!"
end

flow.first

flow.start # start polling the queue.

# => first 
# => second
# =>   arg received: By the way, I'm feeling lucky. Really!
# => last!
```

Motivation
=========

Writing a multi-instance code is really painful.

RPC? API? They are really painful. I just want to write a code, not to define protocol and call API and....

And there are more bad things. If you use RPC or API, you have to know instances. Then you have to know their IP. Then you need to write a config.

Queue make it simple. 
You just call methods via queue.
Every instance just polls the queue.
Every instance does NOT know each other, only knows the queue.
Really simple.

CloudFlow does it simply.

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
