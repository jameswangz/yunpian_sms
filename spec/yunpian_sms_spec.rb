# -*- coding: UTF-8 -*-                           
                                                  
require 'spec_helper'                             
require 'yaml'
require 'logger'                                  

describe YunPianSMS do            
  
  subject(:logger) { Logger.new STDOUT  }
  subject(:configuration) { YAML.load_file('./spec/fixtures/configuration.yml') }
  subject(:api_key) { configuration['api_key']  }

  before do
    YunPianSMS.debug_mode = true                     
    YunPianSMS.logger = logger
  end

  context 'templates' do

    it 'should get error response when api key missing' do
      result = YunPianSMS::Template.all
      expect(result.successful).to be false
    end

    it 'should get all templates successfully' do
      YunPianSMS.api_key = api_key
      result = YunPianSMS::Template.all
      expect(result.successful).to be true
      logger.debug "all templtes #{result.body}"
      expect(YunPianSMS::Template.find(12324235345435).successful).to be false
      result.body.each do |element|
        template_id = element["tpl_id"]
        template_result = YunPianSMS::Template.find template_id
        expect(template_result.successful).to be true
        logger.debug "template #{template_result.inspect}"
      end
    end

  end

  context 'messages' do

    it 'should send single message with template 1 successfully' do
      YunPianSMS.api_key = api_key
      template_id = '2697618'
      mobile_no = configuration['single_mobile_no']
      # 【智能通勤】车辆变更提醒: 尊敬的乘客您好, 您所乘坐的#keyword1#由于#keyword2#, 车牌号变更为#keyword3#, 变更日期范围为#keyword4#, 请提前到乘车站点候车以免耽误您的行程，谢谢。
      params = {
          keyword1: '横琴号十号线',
          keyword2: '车辆定期维修',
          keyword3: '粤C66666',
          keyword4: '2019-05-20 至 2019-05-22'
      }
      result = YunPianSMS::Sender.template_single_send(template_id, mobile_no, params)
      # expect(result.successful).to be true
      logger.debug "result #{result.inspect}"
    end

    it 'should send single message with template 2 successfully' do
      YunPianSMS.api_key = api_key
      template_id = '2834228'
      mobile_no = configuration['single_mobile_no']
      # 【智能通勤】您有一张车票 #reserved_method_ticket_no# 距乘车时间小于#reserved_value# 分钟，线路: #reserved_method_bus_line_full_name#，乘车时间: #reserved_method_departure_at_with_day#， 起点： #reserved_method_source_station_name#， 终点: #reserved_method_destination_station_name#， 车牌号: #reserved_method_bus_plate_number#， 请提前到乘车站点候车以免耽误您的出行。
      params = {
          reserved_method_ticket_no: 'L251201905291617ZFBGVQ11',
          reserved_value: '30',
          reserved_method_bus_line_full_name: '横琴号十号线',
          reserved_method_departure_at_with_day: '2019-05-20 18:00',
          reserved_method_source_station_name: '横琴创意谷',
          reserved_method_destination_station_name: '西江月',
          reserved_method_bus_plate_number: '粤C66666'
      }
      result = YunPianSMS::Sender.template_single_send(template_id, mobile_no, params)
      # expect(result.successful).to be true
      logger.debug "result #{result.inspect}"
    end

    it 'should batch send messages successfully' do
      YunPianSMS.api_key = api_key
      template_id = '2697618'
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
      elapsed_time = Time.now - start_time
      logger.debug "elapsed_time #{elapsed_time.to_i}"
      logger.debug batch_result.inspect
      batch_result.details.each do |result|
        result.body['data'].each do |data|
          logger.debug "#{data['code']} #{data['msg']}"
        end
      end
    end

  end

end
