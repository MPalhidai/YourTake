# YourTake

YourTake is a movie review website created by Michael Palhidai to show Teachers' Curriculum Institute that I am a competent full stack rails developer. TCI and I have the same mission to create a better future by helping our teachers and students. Try out the website at the link below.

* [YourTake](https://yourtake.herokuapp.com/)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Follow the RailsBridge Installfest instructions on how to setup of a Ruby on Rails environment with Git. Make sure to install the rails and bundler gems.

* [RailsBridge](http://installfest.railsbridge.org/installfest/) - Installfest

Current environment:
```
rvm -v 1.29.14
ruby -v 2.5.1p57
rails -v 5.2.1
bundler -v 1.16.1
```

### Installing

In your terminal change directory to where you want to clone this rails application.

CLI:
```
git clone https://github.com/MPalhidai/YourTake.git
cd YourTake
bundle install
rails db:setup
```
### Running local server:

CLI:
```
rails server
```
Open your browser at "localhost:3000".

### Running the tests

JS tests designed for chrome driver with Selenium. Running test may timeout the first time in Chrome with no cached items. Try to run rspec again without changes.

CLI:
```
rspec
```

## Built With

* [TheMovieDB](https://www.themoviedb.org/) - The Movie Database API
* [Devise](https://github.com/plataformatec/devise) - User management
* [Bootstrap](https://github.com/twbs/bootstrap-rubygem) - Page layout
* [FontAwesome](https://github.com/bokmann/font-awesome-rails) - Awesome icons
* [Sendgrid](https://github.com/sendgrid/sendgrid-ruby) - Email distribution
* [LetterOpener](https://github.com/ryanb/letter_opener) - User confirmation in dev.

## Authors

* [Michael Palhidai](https://github.com/MPalhidai)
