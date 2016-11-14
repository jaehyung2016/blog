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
    set_focus_to_email_input();
  });

  function set_focus_to_email_input() {
    var email_input = $("#login_user_email");
    if (email_input.is(":visible")) {
      email_input.focus();
    } else {
      email_input = $("#user_email");
      if (email_input.is(":visible")) {
        email_input.focus();
      }
    }
  }

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
    $("#login_user_email").focus();
  });

  signup_tab_link.on({
    click: function(event) {
      signup_tab_link.parent().addClass("w3-theme-d1");
      login_tab_link.parent().removeClass("w3-theme-d1");
      $("#signup_tab").show();
      $("#login_tab").hide();
      event.preventDefault();
      $("#user_email").focus();
    }, "ajax:success": function(event, data, status, xhr) {
      $(data).attr("data-remote", "true").appendTo("#signup_tab");
      $(this).attr("href", "#signup_tab").removeAttr("data-remote");
      $("#user_email").focus();
    }, "ajax:error": function(event, xhr, status, error) {
      console.log(xhr);
      console.log(status);
      console.log(error);
      $("#signup_tab").html(error);
    }
  });

// sign-up form ajax call response process
  $("#signup_tab").on("ajax:error", function(event, xhr, status, error) {
    console.log(xhr);
    console.log(status);
    console.log(error);
    $(this).empty();
    $(xhr.responseText).attr("data-remote", "true").appendTo(this);
  }).on("ajax:success", function() {
  // TODO // sign-up form ajax call response process
  });
  
// login form ajax call response process
  $("#login_tab").on("ajax:error", function(event, xhr, status, error) {
    console.log(xhr);
    console.log(status);
    console.log(error);
    var form_elem = $(this).children();
    remove_error_message(form_elem);
    var para = $('<p id="error_explanation" class="w3-panel w3-left-align w3-padding w3-red"></P>')
    if ( xhr.responseJSON ) {
      para.html( $("<b/>").text(xhr.responseJSON.error) )
    } else {
      para.html( $("<b/>").text("Unknown error") );
    }
    para.prependTo( form_elem );
  }).on("ajax:success", function(event, data, status, xhr) {
    console.log( data );
    console.log( xhr );
    $("#login_box").hide();
    $("#login_menu").hide();
    show_current_user_menu(data);
    reset_login_form( $(this).children() );
    reset_csrf_token(data.authenticity_token);
  });

// logout
  $("a[href='/logout']").on("ajax:success", function(event, data, status, xhr) {
    $("#login_menu").show();
    hide_current_user_menu();
    reset_csrf_token(data.authenticity_token);
  });

// helper functions
  function show_current_user_menu(login_info) {
    $("#menu_user_name").text(login_info.first_name);
    if (login_info.is_admin) {
      $("#admin_menu").show();
    }
    $("#current_user_menu").show();
  }

  function hide_current_user_menu() {
    $("#current_user_menu").hide();
    $("#menu_user_name").empty();
  }

  function remove_error_message(elem) {
    var error_elem = elem.find("#error_explanation");
    if ( error_elem.length != 0 ) { error_elem.remove(); }
  }

  function reset_login_form(elem) {
    remove_error_message(elem);
    elem.get(0).reset();
  }

  function reset_csrf_token(new_token) {
    $("meta[name='csrf-token']").attr("content", new_token);
    $("input[name='authenticity_token']").val(new_token);
  }

// Search form
  $("#search_form").on({ // TODO
    submit: function(event) {
      event.preventDefault();
      alert( "Not implemented yet");
    }
  });

});
