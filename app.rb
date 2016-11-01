require 'rubygems'
require 'em-websocket'
require 'sinatra/base'
require 'thin'
require 'json'

$channel = EM::Channel.new

EventMachine.run do
  class App < Sinatra::Base

      get '/' do
        File.read(File.expand_path('index.html', settings.root))
      end

      post '/' do
        $channel.push "POST>: #{params[:text]}"
      end
  end
  
  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8081) do |ws|
      ws.onopen {
        sid = $channel.subscribe { |msg| ws.send msg }
        $channel.push "#{sid} connected!"

        ws.onmessage { |msg|
          $channel.push "<#{sid}>: #{msg}"
        }

        ws.onclose {
          $channel.unsubscribe(sid)
        }
      }
  end
  App.run!({:port => 4321})
end


# TODO: properly kill the websocket connection:
#
# def stop_it
#   EventMachine.stop if EventMachine.reactor_running?
# end

# Signal.trap('HUP') { stop_it }