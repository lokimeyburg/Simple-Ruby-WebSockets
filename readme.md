## Simple Ruby Messaging and Presence Example



This is a simple example showing the underlying architecture of writing your own websocket, signaling and presence server in Ruby. This is sort of the most basic way of explaining how [Raptor](https://github.com/lokimeyburg/raptor) works, my own personal websocket server. In a production app you'll also need to write your own authorization method, you'll probably have multiple channels and so you'll need to write a handler to handle subscribing to many different channels.


### Getting Started

```
$ bundle install
$ ruby app.rb
```

Then just open your browser to `http://localhost:8081` to try it out.

