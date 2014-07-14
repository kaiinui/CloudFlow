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

**This code does work on multi instances, though it is like an ordinary code.**

Motivation
=========

Writing a multi-instance code is really painful.

RPC? API? **These are really painful.** I just want to write a code, I don't want to define protocol and call API and....

And there are more bad things. If you use RPC or API, you have to know all instances. Then you have to know their IP. Then you need to write a config. You have to manage the instances.

Queue make it simple. 
You just call methods via queue.
Every instance just polls the queue.
Every instance does NOT know each other, only knows the queue.
Really simple.

CloudFlow does it simply.

![](https://dl.dropboxusercontent.com/u/7817937/_github/cloudflow/cloudflow.jpg)

Install
=========

`gem 'cloud_flow'`

Please note `cloud_flow` is currently WIP and highly experimental.
It's interface can be changed without any anounce.

Usage
=========

- Set AWS key as following. Putting it on `config/aws.rb` and `require_relative 'config/aws'` is recommended way. (or set environment variable.)

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

Just copy an instance to scale.

Protocol
====

###Protocol v0 2014.07.12

When you call a cloudflow method, a message like `method_name(arg1, arg2)` will be sent to SQS. Then an instance polls the message, parse the message and call the method `method_name` with `arg1`, `arg2`.

TODO
=========
- [ ] Write more description.
- [ ] Write more test. (Especially about handling SQS) Currently I wrote about only parsing a message. 
- [ ] Write better doc.

Want to do
========
1. Provide a way to handle ActiveRecord objects easier. Because now you can pass args only String or Number.
2. Provide a way to pass a callback block.

License
===

Copyright (c) 2013 Kai Inui, Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
