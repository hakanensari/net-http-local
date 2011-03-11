require File.expand_path('../test_helper', __FILE__)

class TestMultiplex < Test::Unit::TestCase
  def find_ip
    url = URI.parse('http://jsonip.com')
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.get('/')
    end

    JSON.parse(res.body)['ip']
  end

  def setup
    @old_ip = find_ip
    print "Change #{@old_ip} to: "
    @new_ip = STDIN.gets.chomp
  end

  def teardown
    Net::HTTP.unbind if TCPSocket.respond_to? :original_open
  end

  def test_bind_without_block
    Net::HTTP.bind(@new_ip)
    assert_equal @new_ip, find_ip

    Net::HTTP.unbind
    assert_equal @old_ip, find_ip
  end

  def test_bind_with_block
    Net::HTTP.bind(@new_ip) do
      assert_equal @new_ip, find_ip
    end

    assert_equal @old_ip, find_ip
  end
end
