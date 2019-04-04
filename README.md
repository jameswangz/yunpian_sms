YunPian SMS Ruby SDK
=========

[云片短信](https://www.yunpian.com/doc/zh_CN/introduction/brief.html) Ruby SDK, 非官方。

Table of Contents
-----------------
* [Installation](#installation)
* [Quick Start](#quick-start)
* [License](#license)
* [Contact](#contact)


Installation
------------

You may get the latest stable version from [Rubygems]:

    $ gem install yunpian_sms

For bundler:

    gem 'yunpian_sms'


Quick Start
-----------

~~~ ruby
require 'rubygems'
require 'yunpian_sms'

YunPianSMS.api_key = 'your api key'

# template examples
result = YunPianSMS::Template.all
if result.successful
  result.body.each do |element|
    template_id = element["tpl_id"]
    template = YunPianSMS::Template.find(template_id).body
  end  
else
  # raise error
end
~~~


License
-------

The yunpian_sms ruby gem is licensed under the terms of the MIT license.
See the file LICENSE for details.

Contact
-------

* Author:    James Wang
* Email:     james.wang.z81@gmail.com

