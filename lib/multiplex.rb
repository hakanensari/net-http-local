require 'net/http'

module Multiplex
  def bind(local_ip)
    TCPSocket.instance_eval do
      (class << self; self; end).instance_eval do
        alias_method :original_open, :open

        define_method(:open) do |conn_address, conn_port|
          original_open(conn_address, conn_port, @local_ip)
        end
      end
    end

    if block_given?
      yield
      unbind
    end
  end

  def unbind
    TCPSocket.instance_eval do
      (class << self; self; end).instance_eval do
        alias_method :open, :original_open
        remove_method :original_open
      end
    end
  end
end

module Net
  class HTTP
    extend Multiplex
  end
end
