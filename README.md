[WIP] CloudFlow
=========

I will write it. Not implemented yet.

SQS Powered multi-instance coding made easy.

Fancy syntax
=========

Looks like an ordinary code? It works on multiple instances!

```ruby
cloudflow :myflow do
  func :first do |arg|
    first_result = do_something
    
    myflow.second first_result
  end

  func :second do |first_result|
    second_result = do_something_with_first_result(first_result)

    myflow.third second_result
  end
  
  func :third do |second_result|
    final_result = do_domething_with_second_result(second_result)
    
    save_result_to_somewhere(final_result)
  end
end
```

Scalability
=========

Just copy an instance to scale. Each instances has same environment.

Scaling automatically is also easy.
