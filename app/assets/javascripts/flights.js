var dispatcher = new WebSocketRails('localhost:3000/websocket');
channel = dispatcher.subscribe('flights');
channel.bind('update', function(data) {
  append_flight(data);
});

function append_flight(data) {
  console.log(data);
  return $.getScript(window.location.href);
}