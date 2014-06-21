require_relative 'cloud_flow'

flow = CloudFlow.new("example")
flow.on :first do
  puts "first"
  flow.second("btw I'm feeling lucky.")
end
flow.on :second do |args|
  puts "second"
  puts "received: #{args}"
  flow.third
end
flow.on :third do
  puts "last!"
end

Thread.new do
  100.times do |i|
    flow.first
    sleep 2
  end
end

flow.start