# Install Ruby Gems
* `gem install bundler`
* `bundle install`

# Run App
* `ruby app.rb`
* available at
 * `http://localhost:4567/businesses`
 * `http://localhost:4567/businesses/1`

# Regenerate Database

## Install Perl Libraries
* `curl -L https://cpanmin.us | perl - App::cpanminus`
* `cpanm --installdeps .`

## Run Script
* `perl csv2sqlite.db`
