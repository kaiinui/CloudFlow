[WIP] CloudFlow
=========

SQS Powered multi-instance coding made easy.

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

1. `gem 'cloud_flow'` then `bundle`

2. Set AWS key as following.

```ruby
AWS.config(
  access_key_id: "ACCESS_KEY"
  secret_access_key: "SECRET_KEY"
  # sqs_endpoint: sqs.ap-northeast-1.amazonaws.com # if needed.
)
```

3. create SQS queue on AWS Console (https://console.aws.amazon.com/sqs/home). The name have to be like  `cloudflow_yournamespace`. Then you can do `CloudFlow.new("yournamespace")`. (I will omit this step by automatically creating a queue if does not exist.)

4. `require 'cloud_flow'` and enjoy!


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
