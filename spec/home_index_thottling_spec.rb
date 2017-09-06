require_relative 'rails_helper'

RSpec.describe HomeController do
  def app
    Rails.application
  end

  let(:period) { 1.hours }
  let(:rate_limit) { "10" }

  before do
    ENV['rate_limit'] = rate_limit
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
  end

  describe 'a single request' do
    let(:key) { "rack::attack:#{Time.current.to_i / period}:req/ip:1.2.3.4" }

    before { get '/home/index', {}, 'REMOTE_ADDR' => '1.2.3.4' }

    it 'should set the counter for one request' do
      expect(Rack::Attack.cache.store.read(key)).to eq(1)
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq("ok")
    end
  end

  describe 'multiple requests' do
    let(:key) { "rack::attack:#{Time.current.to_i / period}:req/ip:1.2.3.6" }

    before do
      4.times do
        get '/home/index', {}, 'REMOTE_ADDR' => '1.2.3.6'
      end
    end

    it 'should set the counter for one request' do
      expect(Rack::Attack.cache.store.read(key)).to eq(4)
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq("ok")
    end
  end

  describe "hit rate limit" do
    let(:limit) { rate_limit.to_i }

    it 'changes the request status to 429' do
      (limit + 1).times do |i|
        get '/home/index', {}, "REMOTE_ADDR" => "1.2.3.5"

        if i > limit
          expect(last_response.status).to eq(429)
          expect(last_response.body).to eq("Rate limit exceeded. Try again in #{10.minutes} seconds\n")
        end
      end
    end
  end

end
