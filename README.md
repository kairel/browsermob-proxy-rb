browsermob-proxy-rb
===================

Fork of Ruby client for the BrowserMob Proxy 2.0 REST API.

[![Build Status](https://secure.travis-ci.org/jarib/browsermob-proxy-rb.png)](http://travis-ci.org/jarib/browsermob-proxy-rb)

Use this gem if you have only need to a client , this gem supose the server is already run.



How to use with selenium-webdriver
----------------------------------

Manually:

``` ruby
require 'selenium/webdriver'
require 'browsermob/proxy'

profile = Selenium::WebDriver::Firefox::Profile.new

bm =  BrowserMob::Proxy::Client.new 'localhost', '8080'

proxy = Selenium::WebDriver::Proxy.new(:http => "localhost:9091")

profile.proxy = proxy


driver = Selenium::WebDriver.for :firefox, :profile => profile
wait = Selenium::WebDriver::Wait.new(:timeout => 30)




See also
--------

* http://proxy.browsermob.com/
* https://github.com/lightbody/browsermob-proxy

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright 2011-2013 Jari Bakken

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

