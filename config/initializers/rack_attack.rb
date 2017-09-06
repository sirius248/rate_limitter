class Rack::Attack
  throttle('req/ip', limit: 100, period: 1.hours) do |req|
    req.ip if req.path == '/home/index'
  end
end

Rack::Attack.throttled_response = lambda do |_env|
  [429, {}, ["Rate limit exceeded.\n"]]
end
