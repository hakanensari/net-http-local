# Net::HTTP::Local binds a Net::HTTP request to a specified local address and
# port.
module Net::HTTP::Local
  # Binds to a local IP address.
  #
  # local_address - A local IP address or hostname.
  # local_port    - A local port (default: nil).
  #
  # If given a block, unbinds after the block executes.
  #
  # Returns nothing.
  def bind(local_address, local_port = nil)
    (class << TCPSocket; self; end).instance_eval do
      alias_method :open_with_local, :open
      define_method(:open) do |conn_address, conn_port|
        open_with_local conn_address, conn_port, local_address, local_port
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

  # Unbinds from the local address and port.
  #
  # Returns nothing.
  def unbind
    (class << TCPSocket; self; end).instance_eval do
      alias_method :open, :open_with_local
      remove_method :open_with_local
    end
  end
end

Net::HTTP.extend Net::HTTP::Local if defined? Net::HTTP
Net::HTTPS.extend Net::HTTP::Local if defined? Net::HTTPS
