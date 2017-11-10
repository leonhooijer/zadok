$(document).on("turbolinks:load", function() {
  $('[data-href]').on("click", function() {
    document.location = $(this).data('href');
  });
});
