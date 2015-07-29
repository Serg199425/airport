var dispatcher = new WebSocketRails('localhost:3000/websocket');
channel = dispatcher.subscribe('flights');
channel.bind('update', function(data) {
  append_flight(data);
});

function append_flight(data) {
  if (window.location.pathname == gon.flights_index_path || window.location.pathname == gon.flights_history_path) {
    $('#flights-container').html('<div class="centered flights-empty-container">' +
      '<img alt="Ajax loader" src="/assets/ajax-loader.gif"></div>');
    return $.getScript(window.location.href);
  }
}



$(document).ready(append_flight);
$(document).on('page:load', append_flight);
