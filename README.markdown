Demo application for tog
========================

This is the demo application for http://demo.toghq.com

This is an application with a set of plugins to show some of tog's features. Don't expect a full-of-sense social network!.


Installation
============

* Clone this project (git clone git://github.com/molpe/tog_demo.git)
* This app makes use of git submodules to track plugins, so you will need to download the code for this plugins running: 'git submodule init' and 'git submodule update' from application's root folder.
* Configure your database in config/database.yml and create it! (if not using sqlite). 'rake db:create' won't work. We are investigating this issue.
* Configure your email server in config/environment.rb
* Run migrations with 'rake db:migrate'
* Start your server with 'ruby script/server'
* Point your browser to http://localhost:3000

Copyright (c) 2008-2009 Linking Paths, released under the MIT license