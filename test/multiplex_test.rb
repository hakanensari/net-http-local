$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'json'
require 'multiplex'

class TestMultiplex < Test::Unit::TestCase
  def find_ip
    uri = URI.parse('http://jsonip.com')
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.get('/')
    end

    JSON.parse(res.body)['ip']
  end

  def setup
    unless defined?(@@old_ip)
      @@old_ip = find_ip
      print "Change #{@@old_ip} to: "
      @@new_ip = STDIN.gets.chomp
    end
  end

  def teardown
    Net::HTTP.unbind if TCPSocket.respond_to? :original_open
  end

  def test_bind_without_block
    Net::HTTP.bind(@@new_ip)
    assert_equal @@new_ip, find_ip

    Net::HTTP.unbind
    assert_equal @@old_ip, find_ip
  end

  def test_bind_with_block
    Net::HTTP.bind(@@new_ip) do
      assert_equal @@new_ip, find_ip
    end

    assert_equal @@old_ip, find_ip
  end

  def test_do_not_unbind_when_bind_not_given_block
    Net::HTTP.bind(@@new_ip)
    assert_respond_to TCPSocket, :original_open
  end

  def test_unbind_when_bind_given_block
    Net::HTTP.bind(@@new_ip) {}
    assert_raise NoMethodError do
      TCPSocket.original_open
    end
  end
end
