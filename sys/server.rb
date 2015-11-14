require          'byebug'
require          'webrick'

class Server
  class << self
    attr_accessor :port

    # Serve up the site
    def serve
      server = WEBrick::HTTPServer.new :Port => @port || 4000, :DocumentRoot => 'site/application.html'
      trap('INT') { server.shutdown }
      server.start
    end
  end
end
