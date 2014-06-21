[WIP] CloudFlow
=========

SQS Powered multi-instance coding made easy.

Fancy syntax
=========

Looks like an ordinary code? It works on multiple instances!

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

flow.poll

# => first 
# => second
# =>   arg received: By the way, I'm feeling lucky.
# => last!
```

Scalability
=========

Just copy an instance to scale. Each instances has same environment.

Scaling automatically is also easy.
