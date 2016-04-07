$(document).ready(function() {

  // Turn a form submission into a resourceful GET request
  $('#searchform').submit(function(event) {
    event.preventDefault();
    window.location = "/favourite_languages/" + $('#username').val();
  })
});
