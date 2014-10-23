module Capybara::Poltergeist
  class Server
    attr_reader :socket, :fixed_port, :timeout, :host

    def initialize(host = nil, fixed_port = nil, timeout = nil)
      @host = host
      @fixed_port = fixed_port
      @timeout    = timeout
      start
    end

    def port
      @socket.port
    end

    def timeout=(sec)
      @timeout = @socket.timeout = sec
    end

    def start
      @socket = WebSocketServer.new(host, fixed_port, timeout)
    end

    def stop
      @socket.close
    end

    def restart
      stop
      start
    end

    def send(message)
      @socket.send(message) or raise DeadClient.new(message)
    end
  end
end
