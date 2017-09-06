class Rack::Attack
  throttle('req/ip', limit: ENV['rate_limit'].to_i, period: 1.hours) do |req|
    req.ip if req.path == '/home/index'
  end
end

Rack::Attack.throttled_response = lambda do |_env|
  [429, {}, ["Rate limit exceeded. Try again in #{10.minutes}\n"]]
end
