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

flow.start

# => first 
# => second
# =>   arg received: By the way, I'm feeling lucky.
# => last!
```

Scalability
=========

Just copy an instance to scale. Each instances has same environment.

TODO
=========
1. Write more test. (Especially about handling SQS) Now I wrote only about parsing a message. 
2. Gemify
3. Write doc

Want to do
========
1. Provide a way to handle ActiveRecord objects easier. Because now you can pass args only String or Number.
2. Provide a way to pass callback.
