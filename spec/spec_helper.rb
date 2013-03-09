require 'jouer'
require 'timecop'
require 'rspec'

RSpec.configure do |c|
  c.before do
    @redis = Redis.new
    @redis.flushdb
  end
end