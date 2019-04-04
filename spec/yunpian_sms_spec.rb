# -*- coding: UTF-8 -*-                           
                                                  
require 'spec_helper'                             
require 'yaml'
require 'logger'                                  

describe YunPianSMS do            
  
  subject(:logger) { Logger.new STDOUT  }
  subject(:api_key) { YAML.load_file('./spec/fixtures/configuration.yml')['api_key']  }

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
        logger.debug "template #{template_result.body}"
      end
    end

  end

end
