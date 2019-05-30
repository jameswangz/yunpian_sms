YunPian SMS Ruby SDK
=========

[云片短信](https://www.yunpian.com/doc/zh_CN/introduction/brief.html) Ruby SDK, 非官方，使用 v2 api, 支持以下功能:

* 获取账号所属所有短信模板
* 模板发送单条短信
* 模板群发短信并获取发送成功/失败列表以及总费用

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

# 获取短信模板
result = YunPianSMS::Template.all
if result.successful
  result.body.each do |element|
    template_id = element["tpl_id"]
    template = YunPianSMS::Template.find(template_id).body
  end  
else
  # raise error
end

# 模板单条发送短信
YunPianSMS.api_key = api_key
template_id = 'xxxxxx'
mobile_no = configuration['single_mobile_no']
# 【智能通勤】车辆变更提醒: 尊敬的乘客您好, 您所乘坐的#keyword1#由于#keyword2#, 车牌号变更为#keyword3#, 变更日期范围为#keyword4#, 请提前到乘车站点候车以免耽误您的行程，谢谢。
params = {
  keyword1: '横琴号十号线',
  keyword2: '车辆定期维修',
  keyword3: '粤C66666',
  keyword4: '2019-05-20 至 2019-05-22'
}
result = YunPianSMS::Sender.template_single_send(template_id, mobile_no, params)

# 模板群发短信
YunPianSMS.api_key = api_key
template_id = 'xxxxxx'
mobile_nos = configuration['batch_mobile_nos']
# 【智能通勤】车辆变更提醒: 尊敬的乘客您好, 您所乘坐的#keyword1#由于#keyword2#, 车牌号变更为#keyword3#, 变更日期范围为#keyword4#, 请提前到乘车站点候车以免耽误您的行程，谢谢。
params = {
  keyword1: '横琴号十号线',
  keyword2: '车辆定期维修',
  keyword3: '粤C66666',
  keyword4: '2019-05-20 至 2019-05-22'
}
start_time = Time.now
batch_result = YunPianSMS::Sender.template_batch_send(template_id, mobile_nos, params)
~~~


License
-------

The yunpian_sms ruby gem is licensed under the terms of the MIT license.
See the file LICENSE for details.

Contact
-------

* Author:    James Wang
* Email:     james.wang.z81@gmail.com

