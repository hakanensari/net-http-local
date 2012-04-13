Net::HTTP::Local
================

Net::HTTP::Local allows TCPSocket to bind a Net::HTTP request to a specified
local address and port.

If you are craving cURL's `interface` option, this is what you need.

Installation
------------

```sh
gem install net-http-local'
```

Usage
-----

```ruby
require 'net/http'
require 'net/http/local'

# Bind to 10.1.1.3 in a block.
Net::HTTP.bind '10.1.1.3' do
  res = Net::HTTP.get_response uri
  p JSON.parse(res.body)['ip'] # => 10.1.1.3
end

# Bind and unbind without a block.
Net::HTTP.bind '10.1.1.3'

res = Net::HTTP.get_response(uri)
p JSON.parse(res.body)['ip'] # => 10.1.1.3

Net::HTTP.unbind
```
