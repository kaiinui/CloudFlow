require_relative 'config/aws'
require 'cloud_flow'

flow = CloudFlow.new("hoga")
flow.on :first do
  puts "first"
  flow.second("btw I'm feeling lucky.", "Really!")
end

flow.on :second do |feeling, how_much|
  puts "second"
  puts "  received: #{feeling} #{how_much}"
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