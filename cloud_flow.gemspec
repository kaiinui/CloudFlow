Gem::Specification.new do |s|
  s.name        = 'cloud_flow'
  s.version     = '0.0.3'
  s.date        = '2014-06-21'
  s.summary     = "SQS Powered Multi-instance coding made easy"
  s.description = "SQS Powered Multi-instance coding made easy"
  s.authors     = ["Kai Inui"]
  s.email       = 'me@kaiinui.com'
  s.files       = ["lib/cloud_flow.rb", "lib/flow_method.rb"]
  s.homepage    = 'https://github.com/kaiinui/CloudFlow'
  s.license     = 'MIT'
  s.add_runtime_dependency "aws-sdk"
end