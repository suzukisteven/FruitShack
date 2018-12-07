# README

An ecommerce site built for final assessment at NEXT. Given 7 days and needs to include:
1) A user authentication feature built from scratch (sign up/sign in), i.e. no using clearance/devise gem. But you can use gem bcrypt for password hashing. (Implementing a remember me feature if possible)
Either
2) A user authentication feature using OAuth. You may use the necessary gems here to help you achieve that. OR
Users have a concept of roles (e.g. admin vs regular users) along with proper authorization (eg. only admin can access all resources, only owner can edit resource).
3) A search/filter functionality (for e.g. search for users, search for products). You may use gems here to help you. You are expected to have good knowledge on how to integrate the gem to a Rails application.
4) Integrate with at least 1 external API provider (for e.g. Twilio, Google Maps, Facebook, Cloudinary, Weather API etc.). You may also use necessary gems here.
using OAuth for authentication does not count, unless you're using API to access user details with the access token gotten from OAuth
5) A working AJAX functionality.
Also, you will need to write RSpec tests for your application. Your test should cover the following: - Model validation and association test (for e.g. uniqueness, presence, numericality). - At least 2 model specs, testing any custom model methods (test for happy and edgy paths) (not including the test made above). - At least 1 integration spec using the Capybara library.

The front-end design of the application will not be taken into account. However the user flow of your application should be done well. (eg. user of the application will not have to manually type out the url to navigate to a different page)

You will be expected to demonstrate good knowledge of your code during the code review session.
