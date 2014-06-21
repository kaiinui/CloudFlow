require_relative 'spec_helper'

describe CloudFlow do
  let(:flow) { CloudFlow.new("example") }

  context 'helpers' do
    context '#parse_method_call' do
      context 'when passes foobar(somestr)' do
        let(:call) {flow.send(:parse_method_call, "foobar(somestr)")}
        it {expect(call.name).to eq "foobar"}
        it {expect(call.args).to eq ["somestr"]}
      end
      context 'when passes foobar(1,2,3)' do
        let(:call) {flow.send(:parse_method_call, "foobar(1,2,3)")}
        it {expect(call.name).to eq "foobar"}
        it {expect(call.args).to eq ["1", "2", "3"]}
      end
      context 'when passes foobar()' do
        let(:call) {flow.send(:parse_method_call, "foobar()")}
        it {expect(call.name).to eq "foobar"}
        it {expect(call.args).to eq []}
      end
    end
  end
end
