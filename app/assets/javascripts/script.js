$(document).on("turbolinks:load", function () {
// global caching for frequently accessed elememts
  var elementCaching = {};
  function getCachedElement(selector) {
    if (elementCaching[selector] == undefined) {
      elementCaching[selector] = $(selector);
    }
    return elementCaching[selector];
  }

// show and hide menu items for mobile devices
  var menu_items;
  var show_menu_items = true;

  $("#mobile_menu").on("click", function () {
    if (menu_items == undefined) {
      menu_items = $("#menu_bar").find(".w3-hide-small");
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
  var login_box = $("#login_box");

  $("a[href='#login_box']").on("click", function (event) {
    event.preventDefault();
    login_box.show();
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

  login_box.find(".w3-closebtn").on("click", function () {
    login_box.hide();
  });

// switch tabs in login modal box
  var login_tab_link = $("a[href='#login_tab']");
  var signup_tab_link = $("#signup_tab_link");
  var login_tab = $("#login_tab");
  var signup_tab = $("#signup_tab");

  login_tab_link.on("click", function (event) {
    login_tab_link.parent().addClass("w3-theme-d1");
    signup_tab_link.parent().removeClass("w3-theme-d1");
    login_tab.show();
    signup_tab.hide();
    event.preventDefault();
    $("#login_user_email").focus();
  });

  signup_tab_link.on({
    click: function (event) {
      signup_tab_link.parent().addClass("w3-theme-d1");
      login_tab_link.parent().removeClass("w3-theme-d1");
      signup_tab.show();
      login_tab.hide();
      event.preventDefault();
      $("#user_email").focus();
    }, "ajax:success": function (event, data, status, xhr) {
      var elem = $(data);
      // make_form_remote( elem.find("form") ); // not doing this seems better
      signup_tab.append(elem);
      // not necessary to load the form twice
      $(this).attr("href", "#signup_tab").removeAttr("data-remote");
      $("#user_email").focus();
    }, "ajax:error": function (event, xhr, status, error) {
      log_ajax_error(xhr, status, error);
      signup_tab.html(error);
    }
  });

  function make_form_remote(form) {
    form.attr("data-remote", "true");
    return form
  }

// sign-up form ajax call response process
  signup_tab.on("ajax:error", function (event, xhr, status, error) {
    log_ajax_error(xhr, status, error);
    $(this).empty();
    var elem = $(xhr.responseText);
    make_form_remote( elem.find("form") );
    elem.appendTo(this);
  })
    .on("ajax:success", function () {
      reset_signup_form( $(this).children() );
      login_box.hide();
    });
 
// login form ajax call response process
  login_tab.on("ajax:error", function (event, xhr, status, error) {
    log_ajax_error(xhr, status, error);
    var form_elem = $(this).children();
    remove_error_message(form_elem);
    var para = $('<p id="error_explanation" class="w3-panel w3-left-align w3-padding w3-red"></P>')
    if ( xhr.responseJSON ) {
      para.html( $("<b/>").text(xhr.responseJSON.error) )
    } else {
      para.html( $("<b/>").text("Unknown error") );
    }
    para.prependTo( form_elem );
  })
    .on("ajax:success", function (event, data, status, xhr) {
      login_box.hide(); // Add some visual que for successful login // TODO
      $("#login_menu").hide();
      show_current_user_menu(data);
      reset_login_form( $(this).children() );
      reset_csrf_token(data.authenticity_token);
      show_article_edit_delete_links(data);
    });

  function show_article_edit_delete_links(login_info) {
    var articles = $("article");
    if (login_info.is_admin) {
      show_article_delete_links(articles);
    }

    var articles_of_current_user = articles.filter("[data-authorid='" + login_info.user_id + "']");
    show_article_edit_links(articles_of_current_user);
    show_article_delete_links(articles_of_current_user);
  }

  function show_article_delete_links(articles) {
    var delete_links = articles.find("[data-article-menu='delete']");
    delete_links.show();
  }

  function show_article_edit_links(articles) {
    var edit_links = articles.find("[data-article-menu='edit']");
    edit_links.show();
  }

// logout -- currently logout is done with page redirection for simplicity
/*
  $("a[href='/logout']").on("ajax:success", function (event, data, status, xhr) {
    $("#login_menu").show();
    hide_current_user_menu();
    reset_csrf_token(data.authenticity_token);
  });
*/

// helper functions
  function show_current_user_menu(login_info) {
    getCachedElement("#menu_user_name").text(login_info.first_name);
    if (login_info.is_admin) {
      getCachedElement("#admin_menu").show();
    }
    getCachedElement("#current_user_menu").show();
  }

  function hide_current_user_menu() {
    getCachedElement("#current_user_menu").hide();
    getCachedElement("#menu_user_name").empty();
  }

  function remove_error_message(elem) {
    var error_elem = elem.find("#error_explanation");
    if ( error_elem.length != 0 ) { error_elem.remove(); }
    elem.find(".field_with_errors").removeClass("field_with_errors");
  }

  function reset_login_form(elem) {
    remove_error_message(elem);
    elem.get(0).reset();
  }

  function reset_signup_form(elem) {
    remove_error_message(elem);
    elem.find("input").val("");
  }

  function reset_csrf_token(new_token) {
    getCachedElement("meta[name='csrf-token']").attr("content", new_token);
    $("input[name='authenticity_token']").val(new_token);
  }

  function log_ajax_error(xhr, status, error) {
    console.log(xhr);
    console.log(status);
    console.log(error);
  }

  var list_elem = $("#post_list");
  list_elem.on("ajax:success", function ( event, data, status, xhr) {
    $(this).html(data);
  })
    .on("ajax:error", function ( event, xhr, status, error ) {
      log_ajax_error(xhr, status, error);
    });

// navigation with ajax for browsers that supports HTML5 history API
/*
  if (Modernizr.history) {
    // ajax for posts#show action
    list_elem.on("click", "ul a", function (event) { // jQuery event delegation
      event.preventDefault();
      load_article(this.href);
    });

    // register popstate event handler // TODO
  } else {
  }

// ajax for pagination links
  var main_elem = $("main");
  main_elem.on("ajax:success", function ( event, data, status, xhr) {
    console.log(xhr); // TODO pushState
    console.log(this);
    console.log(this.url);
    $(this).html(data);
  })
    .on("ajax:error", function ( event, xhr, status, error ) {
      log_ajax_error(xhr, status, error);
    });


  function load_article(url) {
    $.ajax({
      url: url + ".js",
      type: "GET"
    })
      .done(function (data, status, xhr) {
        main_elem.html(data);
        update_browser_history(url);
      })
      .fail(function (xhr, status, error) {
        log_ajax_error(xhr, status, error);
      });
  }

  function update_browser_history(url) {
    history.pushState(null, null, url);
    // TODO title change also
  }

*/
});

