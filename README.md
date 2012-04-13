Net::HTTP::Local
================

Net::HTTP::Local binds a Net::HTTP request to a specified local address and
port.

Installation
------------

```sh
gem install net-http-local
```

Usage
-----

A contrived example:

```ruby
require 'json'
require 'net/http'
require 'uri'

require 'net/http/local'

ip = -> do
  uri = URI.parse 'http://jsonip.com'
  res = Net::HTTP.get_response uri
  JSON.parse(res.body)['ip']
end
 
# The default IP address.
p ip.call => # 10.1.1.2

# Bind to 10.1.1.3 in a block.
Net::HTTP.bind '10.1.1.3' do
  p ip.call # => 10.1.1.3
end

# Bind and unbind without a block.
Net::HTTP.bind '10.1.1.3'
p ip.call # => 10.1.1.3
Net::HTTP.unbind
```
