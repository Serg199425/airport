var pageLoad = function ()  {
  switch (window.location.pathname) {
    case gon.flights_index_path:
      $('.menu-bar .flights_index').toggleClass('active');
      break;
    case gon.flights_history_path:
      $('.menu-bar .flights_history').toggleClass('active');
      break;
    case gon.airplanes_index_path:
      $('.menu-bar .airplanes_index').toggleClass('active');
      break;
  };
};

$(document).ready(pageLoad);
$(document).on('page:load', pageLoad);