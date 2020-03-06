require 'webrick'
server = WEBrick::HTTPServer.new({
                                   :DocumentRoot => '.',
                                   :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
                                   :Port => '4000',
                                 })
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/task', WEBrick::HTTPServlet::ERBHandler, 'task.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
# この一行を追記
server.mount('/goya1.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya1.rb')
server.mount('/goya2.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya2.rb')
server.mount('/goya3.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya3.rb')
server.start