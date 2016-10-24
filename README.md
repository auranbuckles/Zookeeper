# Zookeeper

Zookeeper is a <a href="https://github.com/sinatra/sinatra">Sinatra</a> CRUD application that allows users to sign up as zookeepers, create their own zoo, and purchase food to take care of their favorite animals. User information is secured through <a href="https://github.com/codahale/bcrypt-ruby">bcrypt</a>.

To use this app, clone or download this repository. Make sure Ruby is installed on your device. Run `bundle install`, `rake db:migrate`, `rake db:seed` (if you want to add the seed data into the database), and then `shotgun`. The app will be running at port 9393 (localhost:9393).

<a href="https://github.com/auranbuckles/zookeeper/blob/master/LICENSE.txt">License</a>