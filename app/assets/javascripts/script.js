$(document).on("turbolinks:load", function() {
// show and hide menu items for mobile devices
  var menu_items;
  var show_menu_items = true;

  $("#mobile_menu").on("click", function () {
    if (menu_items == undefined) {
      menu_items = $("#menu_bar .w3-hide-small");
    }
    if (show_menu_items) {
      menu_items.removeClass("w3-hide-small");
      show_menu_items = false;
    } else {
      menu_items.addClass("w3-hide-small");
      show_menu_items = true;
    }
  });

// show and hide login modal box
  $("a[href='#login_box']").on("click", function(event) {
    event.preventDefault();
    $("#login_box").show();
  });

  $("#login_box .w3-closebtn").on("click", function() {
    $("#login_box").hide();
  });

// switch tabs in login modal box
  var login_tab_link = $("a[href='#login_tab']");
  var signup_tab_link = $("#signup_tab_link");

  login_tab_link.on("click", function(event) {
    login_tab_link.parent().addClass("w3-theme-d1");
    signup_tab_link.parent().removeClass("w3-theme-d1");
    $("#login_tab").show();
    $("#signup_tab").hide();
    event.preventDefault();
  });

  signup_tab_link.on({
    click: function(event) {
      signup_tab_link.parent().addClass("w3-theme-d1");
      login_tab_link.parent().removeClass("w3-theme-d1");
      $("#signup_tab").show();
      $("#login_tab").hide();
      event.preventDefault();
    }, "ajax:success": function(event, data, status, xhr) {
      $(data).attr("data-remote", "true").appendTo("#signup_tab");
      $(this).attr("href", "#signup_tab").removeAttr("data-remote");
    }, "ajax:error": function(event, xhr, status, error) {
      $("#signup_tab").html(error);
      console.log(xhr);
      console.log(status);
      console.log(error);
    }
  });

// sign-up form ajax call response process
  $("#signup_tab").on("ajax:error", function(event, xhr, status, error) {
    $(this).empty();
    $(xhr.responseText).attr("data-remote", "true").appendTo(this);
    console.log(xhr);
    console.log(status);
    console.log(error);
  }).on("ajax:success", function() {
  // TODO // sign-up form ajax call response process
  });
  

// login form ajax call response process
  $("#login_tab").on("ajax:error", function(event, xhr, status, error) {
    $(this).html(xhr.responseText);
    console.log(xhr);
    console.log(status);
    console.log(error);
  }).on("ajax:success", function() {
  // TODO // login form ajax call response process
  });
});
