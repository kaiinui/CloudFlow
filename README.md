[WIP] CloudFlow
=========

I will write. Not implemented yet.

SQS Powered multi-instance coding made easy, with adequete scalability.

#Fancy syntax

```ruby
cloudflow :myflow do
  func :first do |arg|
    first_result = do_something
    
    myflow.second result: first_result
  end

  func :second do |arg|
    second_result = do_something_with_first_result(arg.first_result)

    myflow.third result: second_result
  end
  
  func :third do |arg|
    final = do_domething_with_second_result(arg.second_result)
    
    save_result_to_somewhere(final)
  end
end
```
