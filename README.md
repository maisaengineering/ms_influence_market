
### Install Nginx if not

    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:nginx/stable
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 00A6F0A3C300EE8C
    sudo apt-get update
    sudo apt-get install nginx

### Check Nginx

Launch Nginx to check if it was installed correctly:

    sudo service nginx start
    sudo service nginx stop
    OR
    sudo service nginx restart

Then start your browser, type your server IP to the address bar, enter. If you
can see the Ngnix default page, `Welcome to Nginx!`, it proves that your Nginx
works well.

Note: you should modify the lines in the file `/etc/nginx/site-enabled/default` from:

    root /usr/share/nginx/www
    server_name localhost

To:

    root /usr/share/nginx/html
    #server_name localhost

Because the Nginx default index page is on the directory `/usr/share/nginx/html`.

At this point, we should setup Nginx to load our influence_market app, do this:

    cd /etc/nginx/sites-enabled/
    sudo rm default
    sudo ln -s ~/influence_market/config/nginx.conf blog
    sudo service nginx reload

Connect to your server again, you will see the rails welcome page, but you
can't access the dynamic content.

### Unicorn setup

    gem 'unicorn'

then update all the gems:

    bundle install

Go to the place which the influence_market app located on, and create a couple of files in
terms of `config/unicorn.rb`  ,`config/nginx.rb`

### config/unicorn.rb
    root = "~/influence_market/"  #path to application root
    working_directory root
    pid "#{root}/tmp/pids/unicorn.pid"
    stderr_path "#{root}/log/unicorn.log"
    stdout_path "#{root}/log/unicorn.log"

    listen "/tmp/unicorn.happycasts.sock"
    worker_processes 2
    timeout 30


    cd ~/influence_market
    cd ~/influence_market/tmp; mkdir -p pids
    cd pids; touch unicorn.pid

### config/nginx.conf
    upstream unicorn {
      server unix:/tmp/unicorn.happycasts.sock fail_timeout=0;
    }

    server {
      listen 80 default deferred;
      # server_name example.com;
      root ~/influence_market/public;

      location ^~ /assets/ {
        gzip_static on;
        expires max;
        add_header Cache-Control public;
      }

      try_files $uri/index.html $uri @unicorn;
      location @unicorn {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://unicorn;
      }

      error_page 500 502 503 504 /500.html;
      client_max_body_size 4G;
      keepalive_timeout 10;
    }

You must build above files manually, if not, unicorn doesn't create them
automatically, and it will not work. After that, start unicorn:

    cd ~/influence_market
    rake assets:precompile RAILS_ENV=production
    bundle exec unicorn -c config/unicorn.rb -E development -D -p 8080
    sudo service nginx restart

The method to stop a unicorn process:

    kill -9 `cat ~/influence_market/tmp/pids/unicorn.pid`

Now reload your server page, the home page occurs, and the dynamic data can
be seen.

