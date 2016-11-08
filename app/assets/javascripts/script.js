$(document).on("turbolinks:load", function() {
// show and hide menu items for mobile devices
  var menu_items;
  var show_menu_items = true;

  $("#mobile_menu").on("click", function () {
    if (menu_items == undefined) {
      menu_items = $("nav .w3-hide-small");
      console.log(menu_items);
    }
    if (show_menu_items) {
      menu_items.removeClass("w3-hide-small");
      show_menu_items = false;
    } else {
      menu_items.addClass("w3-hide-small");
      show_menu_items = true;
    }
  });


});
