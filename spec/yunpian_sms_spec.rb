# -*- coding: UTF-8 -*-                           
                                                  
require 'spec_helper'                             
require 'yaml'
require 'logger'                                  

describe YunPianSMS do            
  
  subject(:logger) { Logger.new STDOUT  }

  before do
    configuration = YAML.load_file('./spec/fixtures/configuration.yml')
    YunPianSMS.debug_mode = true                     
    YunPianSMS.logger = logger
    YunPianSMS.api_key = configuration['api_key']
  end

  context 'templates' do

    it 'should get all templates' do
      all_templates = YunPianSMS::Template.all
      logger.debug "all templtes #{all_templates}"
      all_templates.each do |element|
        template_id = element["tpl_id"]
        template = YunPianSMS::Template.find template_id
        logger.debug "template #{template}"
      end
    end

  end

end
