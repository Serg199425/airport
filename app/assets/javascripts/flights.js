var dispatcher = new WebSocketRails('localhost:3000/websocket');
channel = dispatcher.subscribe('flights');
channel.bind('update', function(flight) {
  append_flight(flight);
});

function append_flight(flight) {
  html = HandlebarsTemplates['flights/table_item']({ flight: flight})
  $('#flights_container').prepend(html)
}