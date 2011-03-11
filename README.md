Multiplex
=========

Multiplex lets you bind Net::HTTP requests to non-default local IP
addresses. If you are craving cURL's interface option, this is what
you need.

[gatling gun](http://upload.wikimedia.org/wikipedia/commons/6/6c/Gatling_gun.jpg)

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
