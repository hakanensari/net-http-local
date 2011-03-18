require 'net/http'

# Multiplex gently monkey-patches TCPSocket to bind a Net::HTTP request to a
# non-default local IP address.
#
# If you are craving cURL's `interface` option, this is what you need.
module Multiplex

  # Binds to a local IP address.
  #
  # If given a block, unbinds at the end of the block.
  def bind(local_ip)
    (class << TCPSocket; self; end).instance_eval do
      alias_method :original_open, :open
      define_method(:open) do |conn_address, conn_port|
        original_open(conn_address, conn_port, local_ip)
      end
    end

    if block_given?
      begin
        yield
      ensure
        unbind
      end
    end
  end

  # Unbinds from the local IP address specified in earlier call to `bind`.
  def unbind
    (class << TCPSocket; self; end).instance_eval do
      alias_method :open, :original_open
      remove_method :original_open
    end
  end
end

class Net::HTTP; extend Multiplex; end
