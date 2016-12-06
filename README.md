# Blog App

This is a blog app that is built with Ruby on Rails.

## Features

* Responsive design that looks nice on mobile devices as well as on computer screens
* Users can sign up and log in to post an article
* Simple admin functions to manage users and posts (admin account need to be set up manually because the web interface is only for normal user registration)
* Log-in is implemented with AJAX to minimize interuption of user activities
* Seamless navigation through articles with AJAX for the web browsers that support HTML5 history API--meaning that users can use back and forward buttons of their web browser just as they normally do. Also, the application gracefully falls back to normal navigating behavior for the web browswers that do not support HTML5 history API--meaning that any modern web browsers can be used to access the blog app.
* Countermeasures against common web security problems such as:
  - Session Fixation by resetting session after login and logout
  - Cross Site Request Forgery by properly updating CSRF token during ajax log-in process

## Features to be added

* Search function
* Tags
* Comments
* Text formatting of an article
