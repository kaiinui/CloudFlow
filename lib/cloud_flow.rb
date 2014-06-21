require_relative 'flow_method'

class CloudFlow
  # @param name [String] defines namespace. then it sees SQS Queue: 'cloudflow_#{name}'
  def initialize(name)
    @namespace = name
    sqs = AWS::SQS.new
    @queue = sqs.queues.named("cloudflow_#{@namespace}")
  end

  # regist func correspond to given func name.
  # please avoid 'on', 'poll' since they are used already by CloudFlow.
  # flow.on(:somefunc, &blk) generates flow#somefunc which is used to call the work.
  # @param name [String] the work's name.
  # @param block [Block] the work.
  def on(name, &block)
    define_sending_method(name)
    define_receiving_method(name, &block)
  end

  # starts its work.
  def start
    @queue.poll do |msg|
      perform_message(msg)
    end
  end

  private

  # defines method which does send message to SQS
  def define_sending_method(name)
    self.class.send(:define_method, name) do |*args|
      @queue.send_message build_method_call(name, *args)
    end
  end

  # defines method which performs desired work.
  def define_receiving_method(name, &block)
    self.class.send(:define_method, "_#{name}") do |*args|
      block.call(*args)
    end
  end

  # @param msg [AWS::SQS::ReceivedMessage]
  def perform_message(msg)
    flow = parse_message(msg)
    self.send("_#{flow.name}", *flow.args)
  rescue
    puts "undefined method: #{msg.body}"
  end

  # @param msg [AWS::SQS::ReceivedMessage]
  # @return [FlowMethod]
  def parse_message(msg)
    parse_method_call(msg.body)
  end

  # builds method_call which is like foobar(1,2,3) or foobar(foo,bar)
  # @return [String]
  def build_method_call(name, *args)
    "#{name.to_s}(#{args.join(",")})"
  end

  # @param method_call [String] built by #build_method_call
  # @return [FlowMethod]
  def parse_method_call(method_call)
    m = FlowMethod.new
    m.name = method_call.split('(')[0]
    m.args = method_call.split('(')[1].split(')')[0].split(",") rescue []
    m
  end
end