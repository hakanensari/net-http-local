Multiplex
=========

Multiplex gently monkey-patches TCPSocket to bind a Net::HTTP request to a
non-default local IP address.

If you are craving cURL's `--interface` option to fire HTTP requests over
multiple local IPs and are looking for a native Ruby solution, this is what
you need.

![tellier](http://totallywiredradio.files.wordpress.com/2009/09/tellier.jpg?w=450&h=450)

Usage
-----

Say the IP of your default interface is 10.1.1.2 and you have a
second interface bound to 10.1.1.3.

    require 'multiplex'
    uri = URI.parse('http://jsonip.com')

    Net::HTTP.bind 10.1.1.3 do
      res = Net::HTTP.get_response(uri)
      puts JSON.parse(res.body)['ip'] # 10.1.1.3
    end

    res = Net::HTTP.get_response(uri)
    puts JSON.parse(res.body)['ip'] # 10.1.1.2

Alternatively, you can bind without a block and then unbind
manually:

    Net::HTTP.bind 10.1.1.3

    res = Net::HTTP.get_response(uri)
    puts JSON.parse(res.body)['ip'] # 10.1.1.3

    Net::HTTP.unbind

    res = Net::HTTP.get_response(uri)
    puts JSON.parse(res.body)['ip'] # 10.1.1.2
